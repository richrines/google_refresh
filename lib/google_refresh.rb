require "google_refresh/version"
require "google_refresh/errors"
require "httparty"
require "oauth2"

module GoogleRefresh
  class Token
    ACCESS_TOKEN_FAILURE_MESSAGE = 'Failed to Retrieve Access Token'
    ACCESS_TYPE = 'offline'
    CONTENT_TYPE = 'application/x-www-form-urlencoded'
    DEFAULT_SCOPE = %w[profile email]
    GOOGLE_AUTHORIZE_URL = 'https://accounts.google.com/o/oauth2/auth'
    GOOGLE_TOKEN_URL = 'https://accounts.google.com/o/oauth2/token'
    GRANT_TYPE = 'refresh_token'
    MISSING_CLIENT_ID_ERROR_MESSAGE = 'Missing Client Id'
    MISSING_CLIENT_SECRET_ERROR_MESSAGE = 'Missing Client Secret'
    MISSING_REFRESH_TOKEN_ERROR_MESSAGE = 'Missing Refresh Token'
    OAUTH_TOKEN_FAILURE_MESSAGE = 'Failed to Retrieve Oauth Token'

    def initialize(client_id, client_secret, redirect_uri, refresh_token, scope=nil)
      @client_id = client_id
      @client_secret = client_secret
      @redirect_uri = redirect_uri
      @refresh_token = refresh_token
      @scope = scope || DEFAULT_SCOPE
    end

    def retrieve_string_token
      ensure_credentials_are_present
      get_access_token
    end

    def retrieve_oauth2_token
      ensure_credentials_are_present
      get_access_token
      create_outh2_client
      return_oauth2_token
    end

    private

    def ensure_credentials_are_present
      if !@client_id
        raise InvalidCredentialsError, MISSING_CLIENT_ID_ERROR_MESSAGE
      elsif !@client_secret
        raise InvalidCredentialsError, MISSING_CLIENT_SECRET_ERROR_MESSAGE
      elsif !@refresh_token
        raise InvalidCredentialsError, MISSING_REFRESH_TOKEN_ERROR_MESSAGE
      else
        true
      end
    end

    def options
      {
        body: {
          client_id: @client_id,
          client_secret: @client_secret,
          refresh_token: @refresh_token,
          grant_type: GRANT_TYPE
        },
        headers: {
          'Content-Type': CONTENT_TYPE

        }
      }
    end

    def get_access_token
      refresh = HTTParty.post(GOOGLE_TOKEN_URL, options)
      if refresh.code == 200
        @token = refresh.parsed_response['access_token']
      else
        raise AccessTokenRetrievalError, ACCESS_TOKEN_FAILURE_MESSAGE
      end
    end

    def create_outh2_client
      @client = OAuth2::Client.new(
        @client_id,
        @client_secret, {
          authorize_url: GOOGLE_AUTHORIZE_URL,
          token_url: GOOGLE_TOKEN_URL
        }
      )

      @client.auth_code.authorize_url(
        {
          scope: @scope,
          redirect_uri: @redirect_uri,
          access_type: ACCESS_TYPE
        }
      )
    end

    def return_oauth2_token
      oauth = OAuth2::AccessToken.from_hash @client, { access_token: @token }
      if oauth
        oauth
      else
        raise OauthTokenRetrievalError, OAUTH_TOKEN_FAILURE_MESSAGE
      end
    end
  end
end

module GoogleRefresh
  class InvalidCredentialsError < StandardError; end
  class AccessTokenRetrievalError < StandardError; end
  class OauthTokenRetrievalError < StandardError; end
end

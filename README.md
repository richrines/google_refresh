# GoogleRefresh

I got tired of writing the boiler plate code to retrieve a new access or oauth2
token projects using Google APIs so I threw it into a gem. It requires that your
app has offline access permissions.

## Installation

Add this line to your application's Gemfile:

    gem 'google_refresh'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google_refresh

## Usage

    # string token
    token = GoogleRefresh::Token.new(client_id, client_secret, refresh_token, scope).retrieve_string_token

    # oauth2 token
    token = GoogleRefresh::Token.new(client_id, client_secret, refresh_token, scope).retrieve_oauth2_token

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

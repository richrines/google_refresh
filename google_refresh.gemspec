# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google_refresh/version'

Gem::Specification.new do |spec|
  spec.name          = "google_refresh"
  spec.version       = GoogleRefresh::VERSION
  spec.authors       = ["Rich Rines"]
  spec.email         = ["rich.rines@me.com"]
  spec.description   = %q{Manage Google Refresh Tokens with Ease}
  spec.summary       = %q{A simple way to retrieve oauth and string tokens via refresh tokens for use with Google apis.}
  spec.homepage      = "http://github.com/richrines/google_refresh"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.post_install_message = "So Refresh"

  spec.required_ruby_version     = '>= 1.9.3'

  spec.add_dependency 'httparty', '>= 0.13.1'
  spec.add_dependency 'oauth2', '>= 1.0.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
end

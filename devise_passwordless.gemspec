$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'devise_passwordless/version'

Gem::Specification.new do |s|
  s.name          = 'devise_passwordless'
  s.version       = DevisePasswordless::VERSION
  s.date          = '2017-06-23'
  s.summary       = "Passwordless authentication for Devise"
  s.description   = "Passwordless authentication for Devise"
  s.authors       = ["Kieran Huggins", "Conner Fritz"]
  s.email         = 'kieran@kieran.ca'
  s.files         = ["lib/devise_passwordless.rb"]
  s.homepage      = 'http://github.com/kieran/devise_passwordless'
  s.license       = 'MIT'
  s.require_path = "lib"
end

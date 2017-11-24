module DevisePasswordless
  autoload :Mailer,   'devise_passwordless/mailer'
  autoload :Mapping,  'devise_passwordless/mapping'
  module Controllers
    autoload :Passwordless, 'devise/controllers/passwordless'
  end
end

require 'devise'
require 'devise_passwordless/routes'
require 'devise_passwordless/rails'

module Devise
  # Public: Validity period of the sign-in token (default: 24 hours).
  # Set passwordless_token_ttl in the Devise configuration file (in config/initializers/devise.rb).
  #
  #   config.passwordless_token_ttl = 24.hours
  mattr_accessor :passwordless_token_ttl
  @@passwordless_token_ttl = 24.hours

  # Public: Token length (default: 16 characters)
  # Set passwordless_token_length in the Devise configuration file (in config/initializers/devise.rb).
  #
  #   config.passwordless_token_length = 16
  mattr_accessor :passwordless_token_length
  @@passwordless_token_length = 16
end

Devise.add_module :passwordless,
  controller: :passwordless,
  route: :passwordless,
  model: 'devise_passwordless/model'
























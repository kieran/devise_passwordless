require 'devise/version'

module DevisePasswordless
  module Mailer

    # Deliver a magic link email
    def passwordless_token(record, opts={})
      @user = record
      devise_mail(@user, :passwordless_token, opts)
    end
  end
end

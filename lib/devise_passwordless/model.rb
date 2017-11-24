require 'active_support/deprecation'

module Devise
  module Models
    # Examples:
    #
    #   User.find(1).invited_to_sign_up?                    # => true/false
    #   User.invite!(:email => 'someone@example.com')       # => send invitation
    #   User.accept_invitation!(:invitation_token => '...') # => accept invitation with a token
    #   User.find(1).accept_invitation!                     # => accept invitation
    #   User.find(1).invite!                                # => reset invitation status and send invitation again
    module Passwordless
      extend ActiveSupport::Concern

      # attr_accessor :skip_invitation
      # attr_accessor :completing_invite
      # attr_reader   :raw_invitation_token

      included do
        # include ::DevisePasswordless::Inviter
        if defined?(ActiveRecord) && defined?(ActiveRecord::Base) && self < ActiveRecord::Base
          # AR defines fields in the schema
          scope :passwordless_token_valid, -> { where("passwordless_token_expired_at >= ?", Time.now) }
        elsif defined?(Mongoid) && defined?(Mongoid::Document) && self < Mongoid::Document && Mongoid::VERSION >= '6.0.0'
          field :passwordless_token, String
          field :passwordless_token_expired_at, DateTime

          scope :passwordless_token_valid, -> { where(:passwordless_token_expired_at.gte => Time.now) }

        end
      end

      def create_passwordless_token!
        if defined?(ActiveRecord) && defined?(ActiveRecord::Base) && self.is_a?(ActiveRecord::Base)
          update_attributes passwordless_token: generate_passwordless_token, passwordless_token_expired_at: Devise.passwordless_token_ttl.from_now
          # update_attributes AR style
        elsif defined?(Mongoid) && defined?(Mongoid::Document) && self.is_a?(Mongoid::Document) && Mongoid::VERSION >= '6.0.0'
          set passwordless_token: generate_passwordless_token
          set passwordless_token_expired_at: Devise.passwordless_token_ttl.from_now
        end
      end

      private
      def generate_passwordless_token
        SecureRandom.hex(Devise.passwordless_token_length / 2)
      end

    end
  end
end

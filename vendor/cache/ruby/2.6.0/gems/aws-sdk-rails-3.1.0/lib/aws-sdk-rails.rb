# frozen_string_literal: true

require_relative 'aws/rails/mailer'

module Aws
  # Use the Rails namespace.
  module Rails
    # @api private
    class Railtie < ::Rails::Railtie
      initializer 'aws-sdk-rails.initialize',
                  before: :load_config_initializers do
        # Initialization Actions
        Aws::Rails.use_rails_encrypted_credentials
        Aws::Rails.add_action_mailer_delivery_method
        Aws::Rails.log_to_rails_logger
      end
    end

    # This is called automatically from the SDK's Railtie, but can be manually
    # called if you want to specify options for building the Aws::SES::Client.
    #
    # @param [Symbol] name The name of the ActionMailer delivery method to
    #   register.
    # @param [Hash] options The options you wish to pass on to the
    #   Aws::SES::Client initialization method.
    def self.add_action_mailer_delivery_method(name = :ses, options = {})
      ActiveSupport.on_load(:action_mailer) do
        add_delivery_method(name, Aws::Rails::Mailer, options)
      end
    end

    # Configures the AWS SDK for Ruby's logger to use the Rails logger.
    def self.log_to_rails_logger
      Aws.config[:logger] = ::Rails.logger
      nil
    end

    # Configures the AWS SDK with credentials from Rails encrypted credentials.
    def self.use_rails_encrypted_credentials
      # limit the config keys we merge to credentials only
      aws_credential_keys = %i[access_key_id secret_access_key session_token]

      Aws.config.merge!(
        ::Rails.application
          .try(:credentials)
          .try(:aws)
          .to_h.slice(*aws_credential_keys)
      )
    end
  end
end

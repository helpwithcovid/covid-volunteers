require_relative 'boot'

require 'rails'
require 'dotenv/load'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Initialize dotenv before booting the main application
if Rails.env.development? || Rails.env.test?
  Dotenv::Railtie.load
end

module CovidVolunteers
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't add field_with_errors class.
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      html_tag
    end

    # From: https://blog.alex-miller.co/rails/2017/01/07/rails-authenticity-token-and-mobile-safari.html.
    config.action_dispatch.default_headers.merge!(
      'Cache-Control' => 'no-store, no-cache'
    )

    # Internationalization
    config.time_zone = 'Pacific Time (US & Canada)'
    config.i18n.load_path += Dir[Rails.root.join('theme', 'locales', '**/*.{rb,yml}')]
    config.i18n.default_locale = :en
    # config.i18n.available_locales = [:en, :es]
  end
end

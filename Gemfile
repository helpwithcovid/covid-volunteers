source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3'
# Use Puma as the app server
gem 'puma', '~> 4.3'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'kaminari'
gem 'acts-as-taggable-on'

# Display SVG's
gem 'inline_svg'

# Linting
gem 'rubocop', require: false
gem 'rubocop-rails', require: false
gem 'rubocop-performance', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.0.rc1'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# DB.
gem 'pg'

# Authentication.
gem 'devise'

# Auto link.
gem 'rinku'

# Sending emails.
gem 'aws-sdk-ses'
gem 'aws-sdk-rails'

# File storage S3
gem 'aws-sdk-s3', require: false

# Image processing
gem 'image_processing'

# Exceptions.
gem 'exception_notification', git: 'https://github.com/smartinez87/exception_notification'

# Search
gem 'pg_search'

# Email obfuscation
gem 'actionview-encoded_mail_to', git: 'https://github.com/mirko314/actionview-encoded_mail_to', branch: 'feature/fix-vanilla-mail-to'

# Environment variables
gem 'dotenv-rails'

# Gravatar images
gem 'gravatar_image_tag'

# .env
gem 'dotenv-rails', groups: [ :development, :test ]

# Booking invites
gem 'icalendar'

# Configuration
gem 'config'

# Country codes
gem 'iso_country_codes', '~> 0.7.8'

# JS Translations
gem 'i18n-js'

# Captcha
gem "json", '~> 2.1.0'
gem "recaptcha"
gem "gibbon", "~> 3.3"

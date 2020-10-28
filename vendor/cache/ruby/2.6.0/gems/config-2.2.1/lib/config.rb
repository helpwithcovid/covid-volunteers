require 'config/compatibility'
require 'config/options'
require 'config/configuration'
require 'config/version'
require 'config/sources/yaml_source'
require 'config/sources/hash_source'
require 'config/validation/schema'
require 'deep_merge'

module Config
  extend Config::Validation::Schema
  extend Config::Configuration.new(
    # general options
    const_name: 'Settings',
    use_env: false,
    env_prefix: 'Settings',
    env_separator: '.',
    env_converter: :downcase,
    env_parse_values: true,
    fail_on_missing: false,
    # deep_merge options
    knockout_prefix: nil,
    merge_nil_values: true,
    overwrite_arrays: true,
    merge_hash_arrays: false,
    validation_contract: nil
  )

  def self.setup
    yield self unless @_ran_once
    @_ran_once = true
  end

  # Create a populated Options instance from a settings file. If a second file is given, then the sections of that
  # file will overwrite existing sections of the first file.
  def self.load_files(*files)
    config = Options.new

    # add settings sources
    [files].flatten.compact.uniq.each do |file|
      config.add_source!(file.to_s)
    end

    config.load!
    config.load_env! if use_env
    config
  end

  # Loads and sets the settings constant!
  def self.load_and_set_settings(*files)
    name = Config.const_name
    Object.send(:remove_const, name) if Object.const_defined?(name)
    Object.const_set(name, Config.load_files(files))
  end

  def self.setting_files(config_root, env)
    [
      File.join(config_root, 'settings.yml').to_s,
      File.join(config_root, 'settings', "#{env}.yml").to_s,
      File.join(config_root, 'environments', "#{env}.yml").to_s,
      *local_setting_files(config_root, env)
    ].freeze
  end

  def self.local_setting_files(config_root, env)
    [
      (File.join(config_root, 'settings.local.yml').to_s if env != 'test'),
      File.join(config_root, 'settings', "#{env}.local.yml").to_s,
      File.join(config_root, 'environments', "#{env}.local.yml").to_s
    ].compact
  end

  def self.reload!
    Object.const_get(Config.const_name).reload!
  end
end

# Rails integration
require('config/integrations/rails/railtie') if defined?(::Rails)

# Sinatra integration
require('config/integrations/sinatra') if defined?(::Sinatra)

require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module PsaManager
  class Application < Rails::Application
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]
    config.default_locale = :es
    config.i18n.fallbacks = true
    config.i18n.fallbacks = [:es]
  end
end

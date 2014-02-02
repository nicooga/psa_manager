require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module PsaManager
  class Application < Rails::Application
    config.action_view.field_error_proc = -> (html_tag, _) do
      include ActionView::Helpers::OutputSafetyHelper
      raw "<div class='has-error'>#{html_tag}</div>"
    end
  end
end

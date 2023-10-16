require_relative 'boot'

# Pick the frameworks you want:
require "action_controller/railtie"
require "active_model/railtie"
require "active_record/railtie"
require "active_job/railtie"
require "action_mailer/railtie"

Bundler.require(*Rails.groups)
require "rails_callback_ex"

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f
  end
end

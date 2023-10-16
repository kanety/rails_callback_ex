# frozen_string_literal: true

module RailsCallbackEx
  class Railtie < Rails::Railtie
    ActiveSupport.on_load :action_controller do
      require_relative 'controller'
      ActionController::Base.include RailsCallbackEx::Controller
    end

    ActiveSupport.on_load :active_record do
      require_relative 'model/callbacks'
      require_relative 'model/validations'
      ActiveModel::Callbacks.include RailsCallbackEx::Model::Callbacks
      ActiveModel::Validations::Callbacks::ClassMethods.include RailsCallbackEx::Model::Validations
      require_relative 'record'
      ActiveRecord::Base.include RailsCallbackEx::Record
    end

    ActiveSupport.on_load :active_job do
      require_relative 'job'
      ActiveJob::Base.include RailsCallbackEx::Job
    end

    ActiveSupport.on_load :action_mailer do
      require_relative 'controller'
      require_relative 'mailer'
      ActionMailer::Base.include RailsCallbackEx::Controller
      ActionMailer::Base.include RailsCallbackEx::Mailer if Rails::VERSION::STRING.to_f >= 7.1
    end
  end
end

# frozen_string_literal: true

require 'active_support/all'

require_relative 'rails_callback_ex/version'
require_relative 'rails_callback_ex/support'
require_relative 'rails_callback_ex/railtie' if defined?(Rails)

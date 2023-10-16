# frozen_string_literal: true

module RailsCallbackEx
  module Model
    module Validations
      extend ActiveSupport::Concern

      included do
        [:before, :after].each do |kind|
          define_method "insert_#{kind}_validation" do |*args, &block|
            options = args.extract_options!
            set_options_for_callback(options)
            options[:prepend] = true if kind == :after
            insert_callback(:validation, kind, *args, options, &block)
          end

          define_method "delete_#{kind}_validation" do |*args, &block|
            options = args.extract_options!
            set_options_for_callback(options)
            delete_callback(:validation, kind, *args, options, &block)
          end
        end
      end
    end
  end
end

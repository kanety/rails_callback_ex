# frozen_string_literal: true

module RailsCallbackEx
  module Model
    module Callbacks
      extend ActiveSupport::Concern

      def define_insert_model_callbacks(*callbacks)
        options = callbacks.extract_options!
        options = {
          skip_after_callbacks_if_terminated: true,
          scope: [:kind, :name],
          only: [:before, :around, :after]
        }.merge!(options)

        types = Array(options.delete(:only))

        callbacks.each do |callback|
          types.each do |type|
            define_singleton_method("insert_#{type}_#{callback}") do |*args, **options, &block|
              options.assert_valid_keys(:if, :unless, :prepend, :before, :after)
              options[:prepend] = true if type == :after
              insert_callback(:"#{callback}", type, *args, options, &block)
            end
          end
        end
      end

      def define_delete_model_callbacks(*callbacks)
        options = callbacks.extract_options!
        options = {
          scope: [:kind, :name],
          only: [:before, :around, :after]
        }.merge!(options)

        types = Array(options.delete(:only))

        callbacks.each do |callback|
          types.each do |type|
            define_singleton_method("delete_#{type}_#{callback}") do |*args, **options, &block|
              options.assert_valid_keys(:if, :unless, :prepend)
              delete_callback(:"#{callback}", type, *args, options, &block)
            end
          end
        end
      end
    end
  end
end

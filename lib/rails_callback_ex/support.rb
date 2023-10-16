# frozen_string_literal: true

module ActiveSupport
  module Callbacks
    module ClassMethods
      def insert_callback(name, *filter_list, &block)
        type, filters, options = normalize_callback_params(filter_list, block)

        self_chain = get_callbacks name
        mapped = filters.map do |filter|
          Callback.build(self_chain, filter, type, options)
        end

        __update_callbacks(name) do |target, chain|
          RailsCallbackEx::Support.insert(chain, type, mapped, options)
          target.set_callbacks name, chain
        end
      end

      def delete_callback(name, *filter_list, &block)
        type, filters, options = normalize_callback_params(filter_list, block)

        __update_callbacks(name) do |target, chain|
          RailsCallbackEx::Support.delete(chain, type, filters, options)
          target.set_callbacks name, chain
        end
      end
    end
  end
end

module RailsCallbackEx
  module Support
    class << self
      def insert(chain, type, mapped, options)
        unless (position = options[:before] || options[:after])
          raise ArgumentError.new("Specify callback using :before or :after")
        end

        if (cb = chain.find { |c| c.matches?(type, position) }) && (index = chain.index(cb))
          index += 1 if (options[:before] && options[:prepend]) || (options[:after] && !options[:prepend])
          mapped.each { |c| chain.insert(index, c) }
        else
          raise ArgumentError.new("Couldn't find callback: #{position}")
        end
      end

      def delete(chain, type, filters, options)
        filters.each do |filter|
          if (cb = chain.find { |c| c.matches?(type, filter) })
            chain.delete(cb)
          else
            raise ArgumentError.new("Couldn't find callback: #{filter}")
          end
        end
      end
    end
  end
end

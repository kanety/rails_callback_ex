# frozen_string_literal: true

module RailsCallbackEx
  module Mailer
    extend ActiveSupport::Concern

    class_methods do
      [:deliver].each do |kind|
        [:before, :after, :around].each do |callback|
          define_method "insert_#{callback}_#{kind}" do |*filters, **options, &blk|
            insert_callback(kind, callback, *filters, **options, &blk)
          end

          define_method "delete_#{callback}_#{kind}" do |*filters, **options, &blk|
            delete_callback(kind, callback, *filters, **options, &blk)
          end
        end
      end
    end
  end
end

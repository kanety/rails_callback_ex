# frozen_string_literal: true

module RailsCallbackEx
  module Controller
    extend ActiveSupport::Concern

    class_methods do
      [:before, :after, :around].each do |callback|
        define_method "insert_#{callback}_action" do |*names, &blk|
          _insert_callbacks(names, blk) do |name, options|
            insert_callback(:process_action, callback, name, options)
          end
        end

        define_method "delete_#{callback}_action" do |*names, &blk|
          _insert_callbacks(names, blk) do |name, options|
            delete_callback(:process_action, callback, name, options)
          end
        end
      end
    end
  end
end

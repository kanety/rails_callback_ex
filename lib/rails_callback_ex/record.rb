# frozen_string_literal: true

module RailsCallbackEx
  module Record
    extend ActiveSupport::Concern

    included do
      define_insert_model_callbacks :save, :create, :update, :destroy
      define_delete_model_callbacks :save, :create, :update, :destroy
    end
  end
end

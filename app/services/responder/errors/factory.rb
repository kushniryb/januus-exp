module Responder
  module Errors
    class Factory < ApplicationService
      def initialize(data, options = {})
        @data    = data
        @options = options
      end

      def call
        return Factory::AR.call(data)                  if active_record?
        return Factory::PassedCollection.call(options) if passed_collection?
        return Factory::NotFound.call(options)         if not_found?

        Factory::Common.call(data, options)
      end

      private

      attr_reader :data, :options

      def active_record?
        data.respond_to?(:errors) && data.errors.any?
      end

      def passed_collection?
        options[:errors]
      end

      def not_found?
        data.nil?
      end
    end
  end
end

module Responder
  module Errors
    class Base < ApplicationService
      # options: title, detail, status, show_data, errors, model, id, ids
      def initialize(data = nil, options = {})
        @data    = data
        @options = options
      end

      def call
        response_params.reject { |_, value| value.nil? }
      end

      private

      attr_reader :data, :options

      def errors
        @errors ||= Factory.call(data, options)
      end

      def response_params
        {
          status: formatted_status,
          errors: errors,
          data:   response_data
        }
      end

      def response_data
        data if show_data?
      end

      def show_data?
        options[:show_data]
      end

      def formatted_status
        StatusFormatter.call(status)
      end

      def status
        @status ||= options.fetch(:status, error_status)
      end

      def error_status
        return Constants::SERVER_ERROR_CODE if errors.blank?

        errors.first.fetch(:status, Constants::SERVER_ERROR_CODE)
      end
    end
  end
end

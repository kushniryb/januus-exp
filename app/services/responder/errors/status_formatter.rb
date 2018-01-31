module Responder
  module Errors
    class StatusFormatter < ApplicationService
      def initialize(status)
        @status = status
      end

      def call
        Rack::Utils::SYMBOL_TO_STATUS_CODE.fetch(status, status)
      end

      private

      attr_reader :status
    end
  end
end

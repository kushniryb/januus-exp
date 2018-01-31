module Responder
  module Errors
    class Mapper < ApplicationService
      def initialize(params = {})
        @id        = params[:id]
        @attribute = params[:attribute]
        @title     = params[:title].to_s
        @detail    = params[:detail].to_s
        @status    = params.fetch(:status, Constants::SERVER_ERROR_CODE)
      end

      def call
        mapped_data.reject { |_, value| value.nil? }
      end

      private

      attr_reader :id, :attribute, :title, :detail, :status

      def mapped_data
        @mapped_data ||= {
          id:     id,
          status: formatted_status,
          title:  title,
          detail: detail,
          source: source
        }
      end

      def formatted_status
        StatusFormatter.call(status)
      end

      def source
        return unless attribute

        {
          pointer: "/data/attributes/#{attribute}"
        }
      end
    end
  end
end

module Responder
  module Errors
    class Factory
      class Common < ApplicationService
        def initialize(error, options = {})
          @error  = error
          @title  = options[:title]
          @detail = options[:detail]
          @status = options.fetch(:status, Constants::SERVER_ERROR_CODE)
        end

        def call
          [
            Mapper.call(
              title:  title,
              detail: detail,
              status: status
            )
          ]
        end

        private

        attr_reader :error, :status

        def detail
          @detail ||= message
        end

        def title
          @title ||= message
        end

        def message
          @message ||= error.respond_to?(:message) ? error.message : error
        end
      end
    end
  end
end

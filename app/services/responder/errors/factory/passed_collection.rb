module Responder
  module Errors
    class Factory
      class PassedCollection < ApplicationService
        def initialize(options = {})
          @errors = options.fetch(:errors, {})
        end

        def call
          errors
            .except(*black_list)
            .map(&method(:format_errors))
            .flatten
        end

        private

        attr_reader :errors

        def format_errors(attribute, messages)
          messages.map { |message| format_error(attribute, message) }
        end

        def format_error(attribute, message)
          Mapper.call(
            attribute: attribute,
            title:     Constants::INVALID_ATTRIBUTE_MESSAGE,
            detail:    full_message(attribute, message),
            status:    Constants::UNPROCESSABLE_ENTITY_CODE
          )
        end

        def full_message(attribute, message)
          "#{attribute.to_s.humanize} #{message}"
        end

        def black_list
          %i[full_messages]
        end
      end
    end
  end
end

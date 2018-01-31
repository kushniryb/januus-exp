module Responder
  module Errors
    class Factory
      class AR < ApplicationService
        def initialize(object)
          @object = object
        end

        def call
          object.errors.map(&method(:format_error))
        end

        private

        attr_reader :object

        def format_error(attribute, message)
          Mapper.call(
            attribute: attribute,
            title:     Constants::INVALID_ATTRIBUTE_MESSAGE,
            detail:    object.errors.full_message(attribute, message),
            status:    Constants::UNPROCESSABLE_ENTITY_CODE
          )
        end
      end
    end
  end
end

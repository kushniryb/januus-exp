module Responder
  module Errors
    module Constants
      ERROR_REGEXP              = /^.*Error/
      INVALID_ATTRIBUTE_MESSAGE = 'Invalid Attribute'.freeze
      SERVER_ERROR_CODE         = Rack::Utils::SYMBOL_TO_STATUS_CODE[:internal_server_error].freeze
      UNPROCESSABLE_ENTITY_CODE = Rack::Utils::SYMBOL_TO_STATUS_CODE[:unprocessable_entity].freeze
      NOT_FOUND_CODE            = Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_found].freeze
    end
  end
end

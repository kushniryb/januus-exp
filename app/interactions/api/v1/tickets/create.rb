module Api
  module V1
    module Tickets
      class Create < ActiveInteraction::Base
        object :params, strip: false, class: ActionController::Parameters

        def execute
          Ticket.create(creation_params)
        end

        private

        def creation_params
          @creation_params ||= normalized_params[:ticket_attributes]
        end

        def normalized_params
          ::Tickets::DataMapper.call(inputs)
        end
      end
    end
  end
end

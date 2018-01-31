module Responder
  module Errors
    class Factory
      class NotFound
        class DetailFormatter < ApplicationService
          def initialize(params = {})
            @id    = params[:id]
            @model = params[:model]
          end

          def call
            return detail          if model && id
            return resource_detail if model

            placeholder
          end

          private

          attr_reader :id, :model

          def detail
            I18n.t(
              'responder.errors.not_found.detail_with_id',
              model:   model_name,
              id:      id,
              default: "#{model} ##{id} was not found"
            )
          end

          def resource_detail
            I18n.t(
              'responder.errors.not_found.detail',
              model:   model_name,
              default: "#{model} was not found"
            )
          end

          def placeholder
            I18n.t(
              'responder.errors.not_found.detail_placeholder',
              default: 'Resource was not found'
            )
          end

          def model_name
            model.to_s.underscore
          end
        end
      end
    end
  end
end

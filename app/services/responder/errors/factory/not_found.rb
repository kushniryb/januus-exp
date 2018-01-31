module Responder
  module Errors
    class Factory
      class NotFound < ApplicationService
        def initialize(params = {})
          @model  = params[:model]
          @ids    = params[:ids]
          @id     = params[:id]
          @detail = params[:detail]
        end

        def call
          return ids.map(&method(:format_error)) if model && ids.present?

          [format_error]
        end

        private

        attr_reader :model, :id, :detail

        def ids
          Array(@ids)
            .push(id)
            .compact
        end

        def format_error(id = nil)
          Mapper.call(
            id:     id,
            title:  title,
            detail: format_detail(id),
            status: Constants::NOT_FOUND_CODE
          )
        end

        def title
          I18n.t('responder.errors.not_found.title', default: 'Record not found')
        end

        def format_detail(id)
          detail || DetailFormatter.call(id: id, model: model)
        end
      end
    end
  end
end

module Errors
  module Render
    extend ActiveSupport::Concern

    included do
      protected

      def respond_with_errors(object, options = {})
        Responder::Errors::Base.call(object, options) do |response|
          render json: response, status: response[:status]
        end
      end

      def not_found!
        respond_with_errors(nil, status: :not_found)
      end

      def params_required!
        respond_with_errors(
          I18n.t('errors.invalid_params.detail'),
          status: :bad_request,
          title:  I18n.t('errors.invalid_params.title')
        )
      end
    end
  end
end

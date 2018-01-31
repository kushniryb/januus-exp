module Api
  class ApplicationController < ::ApplicationController
    include ::Errors::Render

    rescue_from ActiveRecord::RecordNotFound,       with: :not_found!
    rescue_from ActionController::ParameterMissing, with: :params_required!
  end
end

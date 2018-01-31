module Resource
  class Find < ApplicationService
    def initialize(params = {})
      @resource_class = params[:resource_class]
      @value          = params[:value]
      @attribute      = params.fetch(:attribute, :id)
      @strict         = params[:strict]
    end

    def call
      raise ActiveRecord::RecordNotFound if not_found?

      found_resource
    end

    private

    attr_reader :resource_class, :value, :attribute, :strict

    def not_found?
      strict && found_resource.blank?
    end

    def found_resource
      resource_class&.find_by(attribute => value)
    end
  end
end

module Tickets
  class DataMapper < ApplicationService
    def initialize(params = {})
      @params = params
    end

    def call
      {
        ticket_attributes: full_attributes
      }
    end

    private

    attr_reader :params

    def full_attributes
      ticket_attributes.merge(attributes)
    end

    def attributes
      {
        excavator_attributes: excavator_attributes
      }
    end

    def ticket_attributes
      {
        request_id:               root['RequestNumber'],
        sequence_id:              root['SequenceNumber'],
        request_type:             root['RequestType'],
        service_area:             service_area,
        additional_service_areas: additional_service_areas,
        response_due_at:          response_due_at,
        locations:                locations
      }
    end

    def excavator_attributes
      {
        manned:             root['Excavator']['CrewOnsite'],
        company_name:       root['Excavator']['CompanyName'],
        address_attributes: address_attributes
      }
    end

    def address_attributes
      {
        address:  street_address,
        state:    address_info['State'],
        city:     address_info['Place'],
        zip_code: address_info['Zip']
      }
    end

    def street_address
      address_num.join(' ') +
        street['Prefix'] +
        street['Name'] +
        street['Type'] +
        street['Suffix']
    end

    def service_area
      root['ServiceArea']['PrimaryServiceAreaCode']['SACode']
    end

    def additional_service_areas
      root['ServiceArea']['AdditionalServiceAreaCodes']['SACode']
    end

    def response_due_at
      root['DateTimes']['ResponseDueDateTime']
    end

    def locations
      root['ExcavationInfo']['DigsiteInfo']['WellKnownText']
    end

    def address_info
      root['ExcavationInfo']['DigsiteInfo']['AddressInfo']
    end

    def address_num
      address_info['Address']['AddressNum']
    end

    def street
      address_info['Street']
    end

    def root
      params[:params]
    end
  end
end

class TicketDecorator < ApplicationDecorator
  decorates_association :excavator

  delegate :company_name, :manned?, :id, :address,
           to: :excavator, prefix: true, allow_nil: true

  delegate :address_line,
           to: :excavator_address, allow_nil: true

  delegate :coordinates,
           to: :locations, prefix: true, allow_nil: true

  def due_at
    I18n.l(response_due_at, format: :long) if response_due_at
  end

  def service_areas
    [service_area, *additional_service_areas].compact
  end
end

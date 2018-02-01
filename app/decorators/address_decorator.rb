class AddressDecorator < ApplicationDecorator
  def address_line
    [object.address, zip_code, city, state].reject(&:blank?).join(' ')
  end
end

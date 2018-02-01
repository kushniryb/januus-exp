class ExcavatorDecorator < ApplicationDecorator
  decorates_association :address

  def manned?
    manned.present?
  end
end

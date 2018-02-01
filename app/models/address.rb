class Address < ApplicationRecord
  belongs_to :excavator, inverse_of: :address

  validates :address, presence: true
  validates :city,    presence: true
  validates :state,   presence: true
end

class Excavator < ApplicationRecord
  belongs_to :ticket, inverse_of: :excavator

  has_one :address, inverse_of: :excavator

  validates :company_name, presence: true
  validates :ticket,       presence: true
end

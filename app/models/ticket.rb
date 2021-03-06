class Ticket < ApplicationRecord
  has_one :excavator, inverse_of: :ticket, dependent: :destroy

  enum request_type: {
    normal: RequestType::NORMAL,
    urgent: RequestType::URGENT
  }

  validates :request_id,   presence: true
  validates :sequence_id,  presence: true
  validates :request_type, presence: true

  accepts_nested_attributes_for :excavator
end

class Address < ApplicationRecord
  belongs_to :excavator, inverse_of: :address
end

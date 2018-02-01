require 'rails_helper'

describe Address, type: :model do
  before { build(:address) }

  it { should belong_to(:excavator) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
end

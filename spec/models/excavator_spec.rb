require 'rails_helper'

describe Excavator, type: :model do
  before { build(:excavator) }

  it { should belong_to(:ticket) }
  it { should have_one(:address) }
  it { should validate_presence_of(:company_name) }
  it { should validate_presence_of(:ticket) }
  it { should accept_nested_attributes_for(:address) }
end

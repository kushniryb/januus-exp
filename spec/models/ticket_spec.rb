require 'rails_helper'

describe Ticket, type: :model do
  before { build(:ticket) }

  it { should have_one(:excavator) }
  it { should validate_presence_of(:request_id) }
  it { should validate_presence_of(:sequence_id) }
  it { should validate_presence_of(:request_type) }
  it { should accept_nested_attributes_for(:excavator) }
end

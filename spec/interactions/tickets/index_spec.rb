require 'rails_helper'

describe Tickets::Index do
  let(:count)    { Faker::Number.digit.to_i + 1 }
  let!(:tickets) { create_list(:ticket, count) }
  let(:params)   { Faker::Types.hash }
  let(:call)     { described_class.run!(params) }

  it { expect(call).to match(tickets) }
  it { expect(call).to be_decorated }

  context 'with pagination' do
    let(:params) { { page: count, per_page: 1 } }
    let(:ticket) { tickets.last }

    it { expect(call).to match([ticket]) }
  end
end

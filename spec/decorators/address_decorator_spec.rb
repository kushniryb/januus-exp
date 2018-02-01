require 'rails_helper'

describe AddressDecorator do
  let(:resource) { build(:address) }

  subject { resource.decorate }

  describe '#address_line' do
    let(:address)      { resource.address }
    let(:city)         { resource.city }
    let(:zip_code)     { resource.zip_code }
    let(:state)        { resource.state }
    let(:address_line) { [address, zip_code, city, state].join(' ') }

    it { expect(subject.address_line).to eq(address_line) }
  end
end

require 'rails_helper'

describe ExcavatorDecorator do
  let(:resource) { build(:excavator, :with_address) }

  subject { resource.decorate }

  describe 'associations' do
    it { expect(subject.address).to be_decorated_with(AddressDecorator) }
  end

  describe '#manned?' do
    let(:excavator) { build(:excavator, manned: nil) }
    let(:decorator) { excavator.decorate }

    it { expect(subject.manned?).to   eq(resource.manned) }
    it { expect(decorator.manned?).to eq(false) }
  end
end

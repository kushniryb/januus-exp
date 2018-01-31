require 'rails_helper'

describe Responder::Errors::Factory do
  let(:data)    { Faker::WorldOfWarcraft.hero }
  let(:options) { Faker::Types.hash }
  let(:message) { Faker::WorldOfWarcraft.quote }

  context 'with active record object' do
    let(:object) { build(:ticket, request_id: nil) }
    let(:result) { described_class.call(object) }

    before do
      object.save

      expect(described_class::AR).to receive(:call)
                                       .with(object)
                                       .and_return(data)
    end

    it { expect(result).to eq(data) }
  end

  context 'with message' do
    let(:result) { described_class.call(message, options) }

    before { expect(described_class::Common).to receive(:call)
                                                  .with(message, options)
                                                  .and_return(data) }

    it { expect(result).to eq(data) }
  end

  context 'with error' do
    let(:error)  { StandardError.new(message) }
    let(:result) { described_class.call(error, options) }

    before { expect(described_class::Common).to receive(:call)
                                                  .with(error, options)
                                                  .and_return(data) }

    it { expect(result).to eq(data) }
  end

  context 'with nil' do
    let(:result) { described_class.call(nil, options) }

    before do
      expect(described_class::NotFound).to receive(:call)
                                             .with(options)
                                             .and_return(data)
    end

    it { expect(result).to eq(data) }
  end
end

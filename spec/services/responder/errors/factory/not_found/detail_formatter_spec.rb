require 'rails_helper'

describe Responder::Errors::Factory::NotFound::DetailFormatter do
  let(:not_found_code) { Responder::Errors::Constants::NOT_FOUND_CODE }
  let(:detail)         { Faker::WorldOfWarcraft.quote }

  context 'without args' do
    let(:data)   { 'Resource was not found' }
    let(:result) { described_class.call }

    it { expect(result).to eq(data) }
  end

  context 'with args' do
    let(:model) { Ticket }
    let(:id)    { Faker::Number.number }

    context 'with model and id' do
      let(:data)   { "Ticket ##{id} was not found" }
      let(:result) { described_class.call(id: id, model: model) }

      it { expect(result).to eq(data) }
    end

    context 'with model and without id' do
      let(:data)   { 'Ticket was not found' }
      let(:result) { described_class.call(model: model) }

      it { expect(result).to eq(data) }
    end

    context 'with id, but without model' do
      let(:data)   { 'Resource was not found' }
      let(:result) { described_class.call(id: id) }

      it { expect(result).to eq(data) }
    end
  end
end

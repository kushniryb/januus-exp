require 'rails_helper'

describe Responder::Errors::Factory::NotFound do
  let(:not_found_code) { Responder::Errors::Constants::NOT_FOUND_CODE }
  let(:title)          { 'Record not found' }
  let(:detail)         { Faker::WorldOfWarcraft.quote }

  before { expect(described_class::DetailFormatter).to receive(:call).and_return(detail).at_least(:once) }

  context 'without args' do
    before do
      expect(Responder::Errors::Mapper).to receive(:call)
                                             .with(
                                               hash_including(
                                                 id:     nil,
                                                 title:  title,
                                                 detail: detail,
                                                 status: not_found_code
                                               )
                                             )
                                             .once
    end

    it { described_class.call }
  end

  context 'with args' do
    let(:model)  { Ticket }
    let(:ids)    { 5.times.to_a }
    let(:result) { described_class.call(model: model, ids: ids) }

    before do
      expect(Responder::Errors::Mapper).to receive(:call)
                                             .with(
                                               hash_including(
                                                 title:  title,
                                                 detail: detail,
                                                 status: not_found_code
                                               )
                                             )
                                             .exactly(5)
    end

    it { expect(result.length).to eq(5) }
  end
end

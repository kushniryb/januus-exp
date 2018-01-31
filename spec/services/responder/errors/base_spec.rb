require 'rails_helper'

describe Responder::Errors::Base do
  let(:data) { Faker::WorldOfWarcraft.quote }

  context 'with status' do
    let(:options) { Hash[:status, code] }
    let(:error)   { build(:responder_error, :with_status) }
    let(:code)    { error[:status] }
    let(:errors)  { [error] }
    let(:result)  { described_class.call(data, options) }

    before do
      expect(Responder::Errors::Factory).to receive(:call)
                                              .with(data, options)
                                              .and_return(errors)
    end

    it { expect(result[:status]).to eq(code) }
    it { expect(result[:errors]).to eq(errors) }
  end

  context 'without status' do
    let(:server_error_code) { Responder::Errors::Constants::SERVER_ERROR_CODE }
    let(:error)             { build(:responder_error) }
    let(:errors)            { [error] }
    let(:result)            { described_class.call(data) }

    before do
      expect(Responder::Errors::Factory).to receive(:call)
                                              .with(data, {})
                                              .and_return(errors)
    end

    it { expect(result[:status]).to eq(server_error_code) }
    it { expect(result[:errors]).to   eq(errors) }
  end
end

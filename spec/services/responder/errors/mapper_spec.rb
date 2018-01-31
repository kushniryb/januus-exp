require 'rails_helper'

describe Responder::Errors::Mapper do
  context 'without args' do
    let(:server_error_code) { Responder::Errors::Constants::SERVER_ERROR_CODE }
    let(:result)            { described_class.call }

    it { expect(result[:status]).to eq(server_error_code) }
    it { expect(result[:title]).to  eq('') }
    it { expect(result[:detail]).to eq('') }
  end

  context 'with args' do
    context 'common fields' do
      let(:params) { build(:responder_error, :with_status) }
      let(:code)   { params[:status] }
      let(:title)  { params[:title] }
      let(:detail) { params[:detail] }
      let(:result) { described_class.call(params) }

      it { expect(result[:status]).to eq(code) }
      it { expect(result[:title]).to  eq(title) }
      it { expect(result[:detail]).to eq(detail) }
      it { expect(result).not_to      have_key(:source) }
    end

    context 'with symbol status field' do
      let(:status_symbol) { :not_found }
      let(:code)          { Rack::Utils::SYMBOL_TO_STATUS_CODE[status_symbol] }
      let(:params)        { build(:responder_error, status: status_symbol) }
      let(:result)        { described_class.call(params) }

      it { expect(result[:status]).to eq(code) }
    end

    context 'with attribute' do
      let(:attribute) { Faker::Internet.domain_word }
      let(:source)    { Hash[:pointer, "/data/attributes/#{attribute}"] }
      let(:params)    { build(:responder_error, :with_status, attribute: attribute) }
      let(:result)    { described_class.call(params) }

      it { expect(result[:source]).to include(source) }
    end
  end
end

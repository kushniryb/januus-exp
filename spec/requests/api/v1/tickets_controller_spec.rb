require 'rails_helper'

describe Api::V1::TicketsController, type: :request do
  before { post api_v1_tickets_path, params: params }

  context 'with valid params' do
    let(:ticket) { JSON.parse(response.body, symbolize_names: true)[:data][:ticket] }
    let(:params) { build(:api_call) }

    it "returns HTTP status 'ok'" do
      expect(response).to have_http_status :ok
    end

    it 'returns created Ticket' do
      expect(ticket[:id]).not_to                       be_falsy
      expect(ticket[:request_id]).not_to               be_falsy
      expect(ticket[:sequence_id]).not_to              be_falsy
      expect(ticket[:request_type]).not_to             be_falsy
      expect(ticket[:additional_service_areas]).not_to be_falsy
      expect(ticket[:response_due_at]).not_to          be_falsy
      expect(ticket[:locations]).not_to                be_falsy

    end
  end

  context 'with invalid params' do
    let(:params) { build(:api_call).merge(RequestNumber: '') }

    it "returns HTTP status 'unprocessable_entity'" do
      expect(response).to have_http_status :unprocessable_entity
    end

    context 'with invalid nested params' do
      let(:params) do
        build(:api_call)
          .deep_merge(ExcavationInfo: { DigsiteInfo: { AddressInfo: { Place: '' } } })
      end

      it "returns HTTP status 'unprocessable_entity'" do
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end

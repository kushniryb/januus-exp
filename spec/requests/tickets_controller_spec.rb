require 'rails_helper'

describe TicketsController, type: :request do
  describe '#index' do
    let!(:tickets) { create_list(:ticket, 5) }

    before { get tickets_path }

    it { expect(response).to          have_http_status(:ok) }
    it { expect(assigns(:tickets)).to match(tickets) }
  end

  describe '#show' do
    context 'valid' do
      let!(:ticket) { create(:ticket) }

      before { get ticket_path(ticket) }

      it { expect(response).to         have_http_status(:ok) }
      it { expect(assigns(:ticket)).to eq(ticket) }
    end

    context 'invalid' do
      let(:get_ticket) { get ticket_path(id: 0) }

      it { expect{ get_ticket }.to raise_error }
    end
  end
end

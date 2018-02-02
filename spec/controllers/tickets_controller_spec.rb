require 'rails_helper'

describe TicketsController, type: :controller do
  describe '#index' do
    let!(:tickets) { create_list(:ticket, 5) }

    before { get :index }

    it { expect(response).to          have_http_status(:ok) }
    it { expect(response).to          render_template(:index) }
    it { expect(assigns(:tickets)).to match(tickets) }
  end

  describe '#show' do
    context 'valid' do
      let!(:ticket) { create(:ticket) }

      before { get :show, params: { id: ticket.id } }

      it { expect(response).to         have_http_status(:ok) }
      it { expect(response).to         render_template(:show) }
      it { expect(assigns(:ticket)).to eq(ticket) }
    end

    context 'invalid' do
      let(:get_ticket) { get :show, params: { id: 0 } }

      it { expect{ get_ticket }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end

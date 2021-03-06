require 'rails_helper'

describe Api::V1::Tickets::Create do
  let(:call) { described_class.run(params: ActionController::Parameters.new(params)) }
  let(:params) { build(:api_call) }

  context 'with valid attributes' do
    it 'creates a new Ticket' do
      expect{ call }.to change(Ticket, :count).by(1)
    end

    it 'creates a new Excavator' do
      expect{ call }.to change(Excavator, :count).by(1)
    end

    it 'creates a new Address' do
      expect{ call }.to change(Address, :count).by(1)
    end
  end

  context 'with invalid' do
    context 'Ticket attributes' do
      let(:params) { build(:api_call).merge(RequestNumber: nil) }

      it 'does not create a new Ticket' do
        expect{ call }.not_to change(Ticket, :count)
      end

      it 'does not create a new Excavator' do
        expect{ call }.not_to change(Excavator, :count)
      end

      it 'does not create a new Address' do
        expect{ call }.not_to change(Address, :count)
      end
    end

    context 'Excavator attributes' do
      let(:params) { build(:api_call).deep_merge(Excavator: { CompanyName: '' }) }

      it 'does not create a new Ticket' do
        expect{ call }.not_to change(Ticket, :count)
      end

      it 'does not create a new Excavator' do
        expect{ call }.not_to change(Excavator, :count)
      end

      it 'does not create a new Address' do
        expect{ call }.not_to change(Address, :count)
      end
    end

    context 'Address attributes' do
      let(:params) do
        build(:api_call)
          .deep_merge(ExcavationInfo: { DigsiteInfo: { AddressInfo: { Place: '' } } })
      end

      it 'does not create a new Ticket' do
        expect{ call }.not_to change(Ticket, :count)
      end

      it 'does not create a new Excavator' do
        expect{ call }.not_to change(Excavator, :count)
      end

      it 'does not create a new Address' do
        expect{ call }.not_to change(Address, :count)
      end
    end
  end
end

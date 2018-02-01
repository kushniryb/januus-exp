require 'rails_helper'

describe Tickets::DataMapper do
  let(:params) { build(:api_call) }

  subject { described_class.call(params: params) }

  context 'ticket fields' do
    let(:data) { OpenStruct.new(subject[:ticket_attributes]) }

    it { expect(data.request_id).to               eq params[:RequestNumber] }
    it { expect(data.sequence_id).to              eq params[:SequenceNumber] }
    it { expect(data.request_type).to             eq params[:RequestType] }
    it { expect(data.service_area).to             eq params[:ServiceArea][:PrimaryServiceAreaCode][:SACode] }
    it { expect(data.additional_service_areas).to eq params[:ServiceArea][:AdditionalServiceAreaCodes][:SACode] }
    it { expect(data.response_due_at).to          eq params[:DateTimes][:ResponseDueDateTime] }

    context 'excavator fields' do
      let(:excavator_data) { OpenStruct.new(data.excavator_attributes) }

      it { expect(excavator_data.manned).to       eq params[:Excavator][:CrewOnsite] }
      it { expect(excavator_data.company_name).to eq params[:Excavator][:CompanyName] }

      context 'address fields' do
        let(:address_info) { params[:ExcavationInfo][:DigsiteInfo][:AddressInfo] }
        let(:street)       { address_info[:Street] }
        let(:address_num)  { address_info[:Address][:AddressNum].join(' ') }
        let(:street_name) do
          [street[:Prefix], street[:Name], street[:Type], street[:Suffix]].join
        end
        let(:address) { [address_num, street_name].join }

        let(:address_data) { OpenStruct.new(excavator_data.address_attributes) }

        it { expect(address_data.address).to  eq address }
        it { expect(address_data.city).to     eq address_info[:Place] }
        it { expect(address_data.state).to    eq address_info[:State] }
        it { expect(address_data.zip_code).to eq address_info[:Zip] }
      end
    end
  end
end

require 'rails_helper'

describe Responder::Errors::Factory::AR do
  let(:object)                    { build(:ticket, request_id: nil, sequence_id: nil) }
  let(:unprocessable_entity_code) { Responder::Errors::Constants::UNPROCESSABLE_ENTITY_CODE }
  let(:invalid_attribute_message) { Responder::Errors::Constants::INVALID_ATTRIBUTE_MESSAGE }
  let(:result)                    { described_class.call(object) }

  before do
    object.save

    expect(Responder::Errors::Mapper).to receive(:call)
                                           .with(
                                             hash_including(
                                               title:  invalid_attribute_message,
                                               status: unprocessable_entity_code
                                             )
                                           )
                                           .twice
                                           .and_return(:error)
  end

  it { expect(result.length).to eq(2) }
end

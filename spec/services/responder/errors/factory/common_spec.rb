require 'rails_helper'

describe Responder::Errors::Factory::Common do
  let(:message)           { Faker::WorldOfWarcraft.quote }
  let(:server_error_code) { Responder::Errors::Constants::SERVER_ERROR_CODE }

  context 'with error' do
    let(:error) { StandardError.new(message) }

    before do
      expect(error).to                     receive(:message).and_return(message)
      expect(Responder::Errors::Mapper).to receive(:call)
                                             .with(
                                               hash_including(
                                                 detail: message,
                                                 status: server_error_code
                                               )
                                             )
    end

    it { described_class.call(error) }
  end

  context 'with message' do
    context 'without options' do
      before do
        expect(Responder::Errors::Mapper).to receive(:call)
                                               .with(
                                                 hash_including(
                                                   detail: message,
                                                   status: server_error_code
                                                 )
                                               )
      end

      it { described_class.call(message) }
    end

    context 'with title field' do
      let(:title) { Faker::WorldOfWarcraft.quote }

      before { expect(Responder::Errors::Mapper).to receive(:call)
                                                      .with(hash_including(title: title)) }

      it { described_class.call(message, title: title) }
    end

    context 'with status field' do
      let(:code) { Rack::Utils::SYMBOL_TO_STATUS_CODE.keys.sample }

      before { expect(Responder::Errors::Mapper).to receive(:call)
                                                      .with(hash_including(status: code)) }

      it { described_class.call(message, status: code) }
    end
  end
end

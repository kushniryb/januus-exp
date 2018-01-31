require 'rails_helper'

describe Resource::Find do
  let!(:resource)      { create(:ticket) }
  let(:resource_class) { resource.class }

  context 'find by id' do
    let(:value)     { resource.id }
    let(:operation) { described_class.call(resource_class: resource_class, value: value) }

    it { expect(operation).to eq(resource) }
  end

  context 'find by email' do
    let(:value) { resource.request_id }
    let(:operation) do
      described_class.call(
        resource_class: resource_class,
        value:          value,
        attribute:      :request_id
      )
    end

    it { expect(operation).to eq(resource) }
  end

  context 'not found' do
    context 'strict' do
      let(:operation) { described_class.call(resource_class: resource_class, strict: true) }

      it { expect{ operation }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'not strict' do
      let(:operation) { described_class.call(resource_class: resource_class) }

      it { expect{ operation }.not_to raise_error }
      it { expect(operation).to       be_nil }
    end
  end
end

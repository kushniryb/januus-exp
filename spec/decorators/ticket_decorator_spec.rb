require 'rails_helper'

describe TicketDecorator do
  let(:resource) { build(:ticket, :with_excavator, :with_zone) }

  subject { resource.decorate }

  describe 'associations' do
    it { expect(subject.excavator).to be_decorated_with(ExcavatorDecorator) }
  end

  describe '#due_at' do
    let(:ticket)         { build(:ticket, response_due_at: nil) }
    let(:decorator)      { ticket.decorate }
    let(:formatted_date) { I18n.l(resource.response_due_at, format: :long) }

    it { expect(subject.due_at).to   eq(formatted_date) }
    it { expect(decorator.due_at).to be_nil }
  end

  describe '#service_areas' do
    let(:service_areas) { [resource.service_area, *resource.additional_service_areas] }
    let(:ticket)        { build(:ticket, service_area: nil, additional_service_areas: nil) }
    let(:decorator)     { ticket.decorate }

    it { expect(subject.service_areas).to   match(service_areas) }
    it { expect(decorator.service_areas).to be_empty }
  end
end

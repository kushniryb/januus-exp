require 'rails_helper'

feature 'user views a ticket', type: :feature do
  let!(:ticket)   { create(:ticket, :with_zone, :with_excavator) }
  let(:excavator) { ticket.excavator }
  let(:address)   { excavator.address }

  scenario "shows ticket information" do
    visit ticket_path ticket

    expect(page).to have_content("Ticket № #{ticket.id}")
    expect(page).to have_content(ticket.request_id)
    expect(page).to have_content(ticket.sequence_id)
    expect(page).to have_content(ticket.request_type.capitalize)
    expect(page).to have_content(ticket.service_area)
  end

  scenario "shows excavator information" do
    visit ticket_path ticket

    expect(page).to have_content("Excavator № #{excavator.id}")
    expect(page).to have_content(excavator.company_name)
  end

  scenario "shows address information" do
    visit ticket_path ticket

    expect(page).to have_content(address.address)
  end
end

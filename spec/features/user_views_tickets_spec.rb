require 'rails_helper'

feature 'user views a list of tickets', type: :feature do
  context 'when there are existing tickets' do
    let!(:tickets) { create_list(:ticket, 3, :with_zone, :with_excavator) }
    let(:ticket)   { tickets.first }

    scenario 'shows tickets information' do
      visit root_path

      expect(page).to have_content(ticket.request_id)
      expect(page).to have_content(ticket.sequence_id)
      expect(page).to have_content(ticket.service_area)
    end

    scenario 'has pagination' do
      visit root_path

      expect(page).to have_css('ul.pagination')
      expect(page).to have_content("Displaying all #{Ticket.all.size} ticket")
    end
  end

  context 'when there are not tickets' do
    scenario 'shows no tickets' do
      visit root_path

      expect(page).to have_content('No tickets found')
    end
  end
end

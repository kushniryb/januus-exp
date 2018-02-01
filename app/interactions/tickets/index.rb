module Tickets
  class Index < ActiveInteraction::Base
    DEFAULT_PER_PAGE = 15

    integer :page,     default: nil
    integer :per_page, default: DEFAULT_PER_PAGE

    def execute
      TicketDecorator.decorate_collection(tickets)
    end

    private

    def tickets
      Ticket.page(page).per(per_page)
    end
  end
end

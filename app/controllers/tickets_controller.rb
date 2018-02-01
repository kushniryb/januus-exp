class TicketsController < ApplicationController
  before_action :find_ticket!, only: :show

  decorates_assigned :ticket

  def index
    @tickets = Tickets::Index.run!(
      page:     params[:page],
      per_page: params[:per_page]
    )
  end

  private

  def find_ticket!
    @ticket ||= Resource::Find.call(
      resource_class: Ticket,
      value:          params[:id],
      strict:         true
    )
  end
end

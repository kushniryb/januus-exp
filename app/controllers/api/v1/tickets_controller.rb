module Api
  module V1
    class TicketsController < Api::ApplicationController
      def create
        @ticket = Tickets::CreateFromJSON.run(params: params).result

        return respond_with_errors(@ticket) unless @ticket.valid?

        render :show
      end
    end
  end
end

module Api
  module V1
    class TicketsController < Api::ApplicationController
      def create
        @ticket = Api::V1::Tickets::Create.run(params: params).result

        return respond_with_errors(@ticket) unless @ticket.valid?

        render :show
      end
    end
  end
end

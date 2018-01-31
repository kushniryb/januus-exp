module Api
  module V1
    class TicketsController < Api::ApplicationController
      def create
        render :show
      end
    end
  end
end

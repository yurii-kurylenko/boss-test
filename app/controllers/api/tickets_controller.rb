# frozen_string_literal: true

module Api
  class TicketsController < ApiController
    def create
      create_ticket_dto = CreateTicketDto.new(params)
      ticket = TicketServices::CreateTicket.call(create_ticket_dto)
      render json: ticket.to_json(only: [:id, :request_number])
    end
  end
end

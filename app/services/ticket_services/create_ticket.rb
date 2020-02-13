# frozen_string_literal: true

module TicketServices
  class CreateTicket
    include Callable
    def initialize(create_ticket_dto)
      @create_ticket_dto = create_ticket_dto
    end

    def call
      ActiveRecord::Base.transaction do
        ticket = Ticket.new(ticket_hash)
        ticket.excavator = Excavator.new(excavator_hash)
        ticket.save!
        ticket
      end
    end

    private

    def create_ticket_hash
      @create_ticket_hash ||= @create_ticket_dto.to_h
    end

    def ticket_hash
      create_ticket_hash.except(:excavator)
    end

    def excavator_hash
      create_ticket_hash[:excavator]
    end
  end
end

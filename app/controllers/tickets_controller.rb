class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all.preload(:excavator)
  end

  def show
    @ticket = Ticket.find(params.require(:id))
  end
end

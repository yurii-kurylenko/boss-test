require 'rails_helper'

RSpec.describe Api::TicketsController, type: :controller do
  describe "ticket creation" do
    let(:created_ticket) { double('ticket') }
    let(:created_ticket_dto) { double('created_ticket_dto') }
    let(:created_ticket_json) { { id: 1, request_number: '111' }.to_json }

    it "creates a ticket with excavator" do
      expect(created_ticket).to receive(:to_json).and_return(created_ticket_json)
      expect(CreateTicketDto).to receive(:new).and_return(created_ticket_dto)
      expect(TicketServices::CreateTicket).to receive(:call).with(created_ticket_dto).and_return(created_ticket)

      post :create

      expect(response.status).to eq(200)
      expect(response.body).to eq(created_ticket_json)
    end

    it "fails to create a ticket because of database error" do
      expect(created_ticket).to_not receive(:to_json)
      expect(CreateTicketDto).to receive(:new).and_return(created_ticket_dto)
      expect(TicketServices::CreateTicket).to receive(:call).and_raise("database connection error")

      post :create

      expect(response.status).to eq(500)
      expect(JSON.parse(response.body)['error']).to eq('database connection error')
    end
  end
end

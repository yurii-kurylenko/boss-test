describe TicketServices::CreateTicket do
  let(:create_ticket_dto) { double('create_ticket_dto') }
  subject { described_class }

  let(:create_ticket_hash) do
    {
      request_number: '09252012-00001',
      sequence_number: 2421,
      request_type: 'Normal',
      response_due_datetime: DateTime.parse('2011/07/13 23:59:59'),
      primary_service_sa_code: 'ZZGL103',
      additional_service_sa_codes: ['ZZL01', 'ZZL02', 'ZZL03'],
      well_known_text: 'POLYGON data',
      excavator: {
        company_name: 'John Doe CONSTRUCTION',
        crew_on_site: true,
        address: '555 Some RD, SOME PARK, ZZ, 55555'
      }
    }
  end

  it '#call' do
    expect(create_ticket_dto).to receive(:to_h).and_return(create_ticket_hash)
    ticket = nil

    expect {
      ticket = subject.call(create_ticket_dto)
    }.to change { Ticket.count }

    expect(ticket.request_number).to be_present
    expect(ticket.sequence_number).to be_present
    expect(ticket.request_type).to be_present
    expect(ticket.response_due_datetime).to be_present
    expect(ticket.primary_service_sa_code).to be_present
    expect(ticket.additional_service_sa_codes).to be_present
    expect(ticket.well_known_text).to be_present

    excavator = ticket.excavator
    expect(excavator).to be_persisted
    expect(excavator.company_name).to be_present
    expect(excavator.crew_on_site).to be_present
    expect(excavator.address).to be_present
  end
end

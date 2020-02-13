class CreateTicketDto
  attr_reader :request_number, :sequence_number, :request_type, :response_due_datetime,
    :primary_service_sa_code, :additional_service_sa_codes, :well_known_text, :excavator

  def initialize(ticket_data)
    @request_number = ticket_data['RequestNumber']
    @sequence_number = ticket_data['SequenceNumber'].to_i
    @request_type = ticket_data['RequestType']
    response_due_datetime_str = ticket_data.dig('DateTimes', 'ResponseDueDateTime')
    @response_due_datetime = response_due_datetime_str ? DateTime.parse(response_due_datetime_str) : nil
    @primary_service_sa_code = ticket_data.dig('ServiceArea', 'PrimaryServiceAreaCode', 'SACode')
    @additional_service_sa_codes = ticket_data.dig('ServiceArea', 'AdditionalServiceAreaCodes', 'SACode')
    @well_known_text = ticket_data.dig('ExcavationInfo','DigsiteInfo', 'WellKnownText')
    @excavator = build_excavator(ticket_data.fetch('Excavator', {}))
  end

  def to_h
    {
      request_number: request_number,
      sequence_number: sequence_number,
      request_type: request_type,
      response_due_datetime: response_due_datetime,
      primary_service_sa_code: primary_service_sa_code,
      additional_service_sa_codes: additional_service_sa_codes,
      well_known_text: well_known_text,
      excavator: excavator
    }
  end

  private

  def build_excavator(excavator_data)
    {
      company_name: excavator_data['CompanyName'],
      crew_on_site: ActiveModel::Type::Boolean.new.cast(excavator_data['CrewOnsite']),
      address: build_excavator_address(excavator_data)
    }
  end

  def build_excavator_address(excavator_data)
    [
      excavator_data.fetch('Address'),
      excavator_data.fetch('City'),
      excavator_data.fetch('State'),
      excavator_data.fetch('Zip'),
    ].join(', ')
  end
end

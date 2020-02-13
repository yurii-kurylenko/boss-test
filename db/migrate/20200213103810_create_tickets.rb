class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.text :request_number
      t.integer :sequence_number
      t.text :request_type
      t.datetime :response_due_datetime
      t.text :primary_service_sa_code
      t.text :additional_service_sa_codes, array: true
      t.text :well_known_text
      t.timestamps
    end
  end
end

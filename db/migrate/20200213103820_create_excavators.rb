class CreateExcavators < ActiveRecord::Migration[6.0]
  def change
    create_table :excavators do |t|
      t.references :ticket, foreign_key: true
      t.text :company_name
      t.text :address
      t.boolean :crew_on_site
      t.timestamps
    end
  end
end

class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      # mains infos
      t.datetime :start_date
      t.datetime :end_date
      t.integer :attendees_nb
      t.decimal :venue_fee
      t.integer :required_score

      # misc
      t.string :name
      t.text :description
      t.text :rules
      t.text :schedule
      t.text :brackets

      t.timestamps
    end
  end
end

class CreateEvenement < ActiveRecord::Migration[7.2]
  def change
    create_table :evenements do |t|
      t.string :type
      t.datetime :start_date
      t.datetime :end_date
      t.integer :attendees_nb
      t.decimal :venue_fee

      # misc
      t.string :name
      t.text :description
      t.text :rules
      t.text :schedule
      t.text :brackets # WIP

      t.timestamps
    end

    add_reference :evenements, :locations, null: false, foreign_key: true
  end
end

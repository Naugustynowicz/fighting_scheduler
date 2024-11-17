class CreateSport < ActiveRecord::Migration[7.2]
  def change
    create_table :sports do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    add_reference :evenements, :sports, foreign_key: true, null: false
  end
end

class AddForeignKeysToClubs < ActiveRecord::Migration[8.0]
  def change
    add_reference :clubs, :status, null: true, foreign_key: true
    add_reference :clubs, :user, null: true, foreign_key: true # owner
    add_reference :clubs, :sport, null: true, foreign_key: true
    add_reference :clubs, :location, null: true, foreign_key: true
  end
end

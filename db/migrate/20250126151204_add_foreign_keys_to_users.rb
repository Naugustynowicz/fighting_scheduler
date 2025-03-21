class AddForeignKeysToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :club, null: true, foreign_key: true
    add_reference :users, :team, null: true, foreign_key: true
    add_reference :users, :location, null: true, foreign_key: true
  end
end

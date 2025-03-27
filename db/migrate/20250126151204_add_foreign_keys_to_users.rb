class AddForeignKeysToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :club, null: true, foreign_key: { on_delete: :nullify }
    add_reference :users, :team, null: true, foreign_key: { on_delete: :nullify }
    add_reference :users, :location, null: true, foreign_key: { on_delete: :nullify }
  end
end

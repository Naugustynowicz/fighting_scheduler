class AddForeignKeysToClubs < ActiveRecord::Migration[8.0]
  def change
    add_reference :clubs, :status, null: true, foreign_key: { on_delete: :nullify }
    add_reference :clubs, :user, null: true, foreign_key: { on_delete: :nullify } # owner
    add_reference :clubs, :sport, null: true, foreign_key: { on_delete: :nullify }
    add_reference :clubs, :location, null: true, foreign_key: { on_delete: :nullify }
  end
end

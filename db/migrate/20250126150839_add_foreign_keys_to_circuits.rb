class AddForeignKeysToCircuits < ActiveRecord::Migration[8.0]
  def change
    add_reference :circuits, :user, null: true, foreign_key: { on_delete: :nullify } # organisateur
    add_reference :circuits, :status, null: true, foreign_key: { on_delete: :nullify }
  end
end

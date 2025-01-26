class AddForeignKeysToCircuits < ActiveRecord::Migration[8.0]
  def change
    add_reference :circuits, :user, null: true, foreign_key: true # organisateur
    add_reference :circuits, :status, null: true, foreign_key: true
  end
end

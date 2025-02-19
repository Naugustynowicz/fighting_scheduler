class AddForeignKeysToEvents < ActiveRecord::Migration[8.0]
  def change
    add_reference :events, :user, null: true, foreign_key: true # organisateur
    add_reference :events, :circuit, null: true, foreign_key: true
    add_reference :events, :status, null: true, foreign_key: true
    add_reference :events, :location, null: true, foreign_key: true
    add_reference :events, :sport, null: true, foreign_key: true
    add_reference :events, :type_event, null: true, foreign_key: true
  end
end

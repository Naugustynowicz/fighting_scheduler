class AddForeignKeysToTeams < ActiveRecord::Migration[8.0]
  def change
    add_reference :teams, :club, null: true, foreign_key: { on_delete: :nullify }
  end
end

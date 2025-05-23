class AddMatchModel < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.references :event, null: false, foreign_key: { on_delete: :cascade }
      t.references :user1, null: true, foreign_key: { to_table: 'users', on_delete: :cascade }
      t.references :user2, null: true, foreign_key: { to_table: 'users', on_delete: :cascade }
      t.references :winner, null: true, foreign_key: { to_table: 'users', on_delete: :cascade }
      t.bigint :previous_match_1, null: true
      t.bigint :previous_match_2, null: true
      t.bigint :next_match, null: true

      t.timestamps
    end

    remove_column :events, :brackets, :string
    add_reference :events, :bracket, foreign_key: { to_table: :matches, on_delete: :cascade }
  end
end

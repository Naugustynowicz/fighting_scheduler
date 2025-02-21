class AddMatchModel < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user1, null: false, foreign_key: { to_table: 'users' }
      t.references :user2, null: false, foreign_key: { to_table: 'users' }
      t.references :winner, null: true, foreign_key: { to_table: 'users' }

      t.timestamps
    end

    # add_foreign_key :matches, :users, column: :user1, primary_key: :id
    # add_foreign_key :matches, :users, column: :user2, primary_key: :id
    # add_foreign_key :matches, :users, column: :winner, primary_key: :id
  end
end

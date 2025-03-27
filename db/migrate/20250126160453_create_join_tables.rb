class CreateJoinTables < ActiveRecord::Migration[8.0]
  def change
    create_join_table :statuses, :events do |t|
      t.index :status_id
      t.index :event_id

      t.timestamps
    end

    create_join_table :statuses, :circuits do |t|
      t.index :status_id
      t.index :circuit_id

      t.timestamps
    end

    create_join_table :statuses, :clubs do |t|
      t.index :status_id
      t.index :club_id

      t.timestamps
    end

    create_join_table :users, :roles do |t|
      t.index :user_id
      t.index :role_id

      t.timestamps
    end

    # event attendees
    create_join_table :users, :events do |t|
      t.index :user_id
      t.index :event_id

      t.references :circuit, null: true, foreign_key: { on_delete: :nullify }

      t.timestamps
    end

    create_join_table :teams, :events do |t|
      t.index :team_id
      t.index :event_id
      t.references :circuit, null: true, foreign_key: { on_delete: :nullify }

      t.timestamps
    end
  end
end

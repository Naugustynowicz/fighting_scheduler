class CreateJoinTables < ActiveRecord::Migration[8.0]
  def change
    create_join_table :statuses, :events do |t|
      t.timestamps
    end

    create_join_table :statuses, :circuits do |t|
      t.timestamps
    end

    create_join_table :statuses, :clubs do |t|
      t.timestamps
    end

    create_join_table :users, :roles do |t|
      t.timestamps
    end

    # event attendees
    create_join_table :users, :events do |t|
      t.timestamps
    end

    create_table :users_events_circuits, id: false do |t|
      t.references :user
      t.references :event
      t.references :circuit
      t.integer :score

      t.timestamps
    end

    create_table :teams_events_circuits, id: false do |t|
      t.references :team
      t.references :event
      t.references :circuit
      t.integer :score

      t.timestamps
    end
  end
end

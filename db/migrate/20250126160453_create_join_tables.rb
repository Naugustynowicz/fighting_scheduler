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
      t.references :circuit, null: true, foreign_key: true

      t.timestamps
    end

    create_join_table :teams, :events do |t|
      t.references :circuit, null: true, foreign_key: true

      t.timestamps
    end
  end
end

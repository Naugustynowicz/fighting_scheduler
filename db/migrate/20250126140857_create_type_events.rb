class CreateTypeEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :type_events do |t|
      t.string :name

      t.timestamps
    end
  end
end

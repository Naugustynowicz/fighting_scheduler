class CreateLocation < ActiveRecord::Migration[7.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :other
      t.string :street
      t.string :city
      t.string :postal_code
      t.string :country

      t.timestamps
    end
  end
end

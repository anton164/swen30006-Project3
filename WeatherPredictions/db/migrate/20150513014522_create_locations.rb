class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :postal_code

      t.timestamps null: false
    end
  end
end

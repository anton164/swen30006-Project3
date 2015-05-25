class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.string :condition
      t.string :time
      t.float :precitipation
      t.float :wind_direction
      t.float :wind_speed
      t.float :temperature

      t.timestamps null: false
    end
  end
end

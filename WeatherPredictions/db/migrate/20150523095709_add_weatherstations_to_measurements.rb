class AddWeatherstationsToMeasurements < ActiveRecord::Migration
  def change
    add_reference :measurements, :weatherstation, index: true
    add_foreign_key :measurements, :weatherstations
  end
end

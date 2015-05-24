class RemovePrecitipationFromMeasurements < ActiveRecord::Migration
  def change
  	remove_column :measurements, :precitipation
  end
end

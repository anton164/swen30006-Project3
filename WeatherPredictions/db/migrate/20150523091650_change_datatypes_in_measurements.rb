class ChangeDatatypesInMeasurements < ActiveRecord::Migration
  def change
  	change_column :measurements, :time, :datetime
  end
end

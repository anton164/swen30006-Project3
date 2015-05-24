class AddPrecipitationToMeasurements < ActiveRecord::Migration
  def change
    add_column :measurements, :precipitation, :float
  end
end

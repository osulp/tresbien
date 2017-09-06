class AddPerDiemToTravelCities < ActiveRecord::Migration[5.1]
  def change
    add_column :travel_cities, :per_diem, :string
  end
end

class AddPerDiemToTravelItineraries < ActiveRecord::Migration[5.1]
  def change
    add_column :travel_itineraries, :per_diem, :float
  end
end

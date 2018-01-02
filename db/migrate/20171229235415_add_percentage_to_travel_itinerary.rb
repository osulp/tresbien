class AddPercentageToTravelItinerary < ActiveRecord::Migration[5.1]
  def change
    add_column :travel_itineraries, :percentage, :integer
  end
end

class AddTravelCityToTravelItineraries < ActiveRecord::Migration[5.1]
  def change
    add_reference(:travel_itineraries, :travel_city, foreign_key: true)
  end
end

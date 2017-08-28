class AddCountryToTravelItinerary < ActiveRecord::Migration[5.1]
  def change
    add_column :travel_itineraries, :country, :string
  end
end

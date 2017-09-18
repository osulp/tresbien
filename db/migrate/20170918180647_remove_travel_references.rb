class RemoveTravelReferences < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:travel_itineraries, :travel_city)
    remove_reference(:expense_others, :travel_itinerary)
  end
end

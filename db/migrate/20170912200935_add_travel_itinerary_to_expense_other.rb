class AddTravelItineraryToExpenseOther < ActiveRecord::Migration[5.1]
  def change
    add_reference(:expense_others, :travel_itinerary, foreign_key: true)
  end
end

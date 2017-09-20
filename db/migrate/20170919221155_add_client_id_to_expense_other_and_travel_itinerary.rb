class AddClientIdToExpenseOtherAndTravelItinerary < ActiveRecord::Migration[5.1]
  def change
    add_column :expense_others, :client_id, :string
    add_column :travel_itineraries, :client_id, :string
  end
end

class AddReimbursementRequestToTravelItineraries < ActiveRecord::Migration[5.1]
  def change
    add_reference :travel_itineraries, :reimbursement_request, foreign_key: true
  end
end

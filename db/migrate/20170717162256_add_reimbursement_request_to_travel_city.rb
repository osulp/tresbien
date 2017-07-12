class AddReimbursementRequestToTravelCity < ActiveRecord::Migration[5.1]
  def change
    add_reference :travel_cities, :reimbursement_request, foreign_key: true
  end
end

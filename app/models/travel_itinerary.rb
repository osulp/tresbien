class TravelItinerary < ApplicationRecord
  belongs_to :reimbursement_request, inverse_of: :travel_itineraries
end

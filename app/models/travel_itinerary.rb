# frozen_string_literal: true

class TravelItinerary < ApplicationRecord
  belongs_to :reimbursement_request, inverse_of: :travel_itineraries
  validates :date, presence: true
  validates :break, presence: true
  validates :lunch, presence: true
  validates :dinner, presence: true
  validates :hotel, presence: true
end

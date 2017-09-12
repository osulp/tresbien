# frozen_string_literal: true

class TravelItinerary < ApplicationRecord
  belongs_to :reimbursement_request, inverse_of: :travel_itineraries
  belongs_to :travel_city, inverse_of: :travel_itineraries
  has_one :expense_other, inverse_of: :travel_itinerary
  validates :date, presence: true
  validates :break, presence: true
  validates :lunch, presence: true
  validates :dinner, presence: true
  validates :hotel, presence: true

  before_save :calculate_amount

  private

  def calculate_amount
    self.amount = (self.break.to_f + self.lunch.to_f + self.dinner.to_f + self.hotel.to_f).round(2)
  end
end

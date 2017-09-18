# frozen_string_literal: true

class TravelItinerary < ApplicationRecord
  belongs_to :reimbursement_request, inverse_of: :travel_itineraries
  validates :date, presence: true
  validates :break, presence: true
  validates :lunch, presence: true
  validates :dinner, presence: true
  validates :hotel, presence: true

  before_save :calculate_amount

  def location_label
    "#{city}, #{state} (#{country})"
  end

  private

  def calculate_amount
    self.amount = (self.break.to_f + self.lunch.to_f + self.dinner.to_f + self.hotel.to_f).round(2)
  end
end

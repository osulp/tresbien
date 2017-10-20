# frozen_string_literal: true

class TravelItinerary < ApplicationRecord
  belongs_to :reimbursement_request, inverse_of: :travel_itineraries
  validates :date, presence: true
  validates :break, presence: true
  validates :lunch, presence: true
  validates :dinner, presence: true
  validates :hotel, presence: true
  validate :above_per_diem

  before_save :calculate_amount

  def location_label
    "#{city}, #{state} (#{country})"
  end

  private

  def calculate_amount
    total = (self.break.to_f + self.lunch.to_f + self.dinner.to_f + self.hotel.to_f).round(2)
    self.amount = [total, self.per_diem].min
  end

  def above_per_diem
    total = (self.break.to_f + self.lunch.to_f + self.dinner.to_f + self.hotel.to_f).round(2)
    if total > self.per_diem && reimbursement_request.expense_others.none? { |e| e.above_per_diem_expense && e.from_date.to_date == self.date.to_date }
      reimbursement_request.errors.add(:base, "An itinerary row has an amount ($#{sprintf('%.2f', total)}) above per diem, update the values or click the button claim the extra amount above per diem as an expense.", target_nav_panel_href: 'itinerary_panel')
    end
  end
end

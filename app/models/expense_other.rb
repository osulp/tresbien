# frozen_string_literal: true

class ExpenseOther < ApplicationRecord
  scope :above_per_diem, -> { where( "travel_itinerary_id IS NOT NULL")}
  scope :not_above_per_diem, -> { where( travel_itinerary_id: nil)}
  belongs_to :reimbursement_request
  belongs_to :travel_itinerary, inverse_of: :expense_other
  has_one :ExpenseType
  validates :expense_type_id, :from_date, :to_date, :amount, presence: true
end

# frozen_string_literal: true

class ExpenseOther < ApplicationRecord
  scope :above_per_diem, -> { where( expense_type_id: ExpenseType.above_per_diem.select(:id) ) }
  scope :not_above_per_diem, -> { where.not( expense_type_id: ExpenseType.above_per_diem.select(:id) ) }
  belongs_to :reimbursement_request
  belongs_to :travel_itinerary, inverse_of: :expense_other
  has_one :ExpenseType
  validates :expense_type_id, :from_date, :to_date, :amount, presence: true
end

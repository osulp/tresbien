# frozen_string_literal: true

class ExpenseOther < ApplicationRecord
  belongs_to :reimbursement_request
  has_one :ExpenseType
  validates :expense_type_id, :from_date, :to_date, :amount, presence: true
end

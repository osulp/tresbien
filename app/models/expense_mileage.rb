# frozen_string_literal: true

class ExpenseMileage < ApplicationRecord
  belongs_to :reimbursement_request
  validates :from_date, :to_date, :amount, :miles, :amount, presence: true
end

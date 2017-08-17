# frozen_string_literal: true

class ExpenseAirfare < ApplicationRecord
  belongs_to :reimbursement_request
  validates :from_date, :to_date, :amount, :from_location, :to_location, presence: true
end

# frozen_string_literal: true

class ExpenseMileage < ApplicationRecord
  belongs_to :reimbursement_request
  validates :from_date, :to_date, :amount, :miles, :amount, :mileage_rate, presence: true

  def mileage_rate_or_default
    mileage_rate || ApplicationConfiguration.mileage_rate.pluck(:value).first.to_f
  end
end

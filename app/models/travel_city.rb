# frozen_string_literal: true

class TravelCity < ApplicationRecord
  belongs_to :reimbursement_request
  validates :from_date, presence: true
  validates :to_date, presence: true
  validates :hotel_rate, presence: true
  validates :state, presence: true
  validates :city, presence: true
end

# frozen_string_literal: true

class ReimbursementRequest < ApplicationRecord
  attr_accessor :accounting_total, :airfare_total, :mileage_total, :itinerary_total, :other_total
  belongs_to :claimant, class_name: 'User'
  belongs_to :certifier, class_name: 'User'
  belongs_to :status, inverse_of: :reimbursement_requests
  has_many :accountings
  has_many :expense_airfares
  has_many :expense_mileages
  has_many :expense_others
  has_many :travel_cities
  has_many :travel_itineraries
  has_many :attachments
  accepts_nested_attributes_for :accountings, :expense_airfares, :expense_mileages, :expense_others, :travel_itineraries, :travel_cities, :claimant, :certifier, :attachments, allow_destroy: true

  validates :certifier_id, presence: true
  validates :identifier, presence: true, length: { is: 15 }

  # Calculate the grand total for the reimbursement request
  def calculate_grand_total
    set_totals
    self.grand_total = totals.sum
  end

  # set individual totals for each child model
  def set_totals
    self.accounting_total = get_total_sum(accountings)
    self.airfare_total = get_total_sum(expense_airfares)
    self.mileage_total = get_total_sum(expense_mileages)
    self.itinerary_total = get_total_sum(travel_itineraries)
    self.other_total = get_total_sum(expense_others)
  end

  # return an array of all totals; not useful for changing these values
  def totals
    [accounting_total, airfare_total, mileage_total, other_total, itinerary_total]
  end

  # return an array of all models; not useful for changing these values
  def models
    [accountings, expense_airfares, expense_mileages, expense_others, travel_itineraries, attachments]
  end

  def children
    @children ||= attachments.all
  end

  private

  # return the sum of the amounts of each model in models
  def get_total_sum(models)
    models.map(&:amount).sum
  end
end

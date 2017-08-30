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
  has_many :status_comments
  accepts_nested_attributes_for :accountings, :expense_airfares, :expense_mileages, :expense_others, :travel_itineraries, :travel_cities, :claimant, :certifier, :attachments, allow_destroy: true

  validates :certifier_id, presence: true
  # validates :identifier, presence: true, length: { is: 15 }

  before_create :generate_identifier

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
  
  # sets the identifier to the first 5/6 chars of the city name, the first 2 chars of the state abbr and mmddyyyy; always returns 15 chars
  def generate_identifier
    travel = get_first_travel_itinerary
    country = get_country_abbreviation(travel)
    state = get_truncated_state(travel, country)
    city_name = get_truncated_city_name(travel, state)
    date = get_date(travel)
    self.identifier = city_name + state + date
  end

  # returns the reimbursement request's travel itineraries sorted by date
  def get_first_travel_itinerary
    travel_itineraries.to_a.sort_by!(&:date).first
  end

  # returns the country abbreviation for the country stored in the first travel itinerary
  def get_country_abbreviation(first_itinerary)
    CS.countries.key(first_itinerary.country)
  end

  # returns the first two characters of the state abbreviation for the first travel itinerary in travel_itineraries
  def get_truncated_state(first_itinerary, country)
    CS.get(country).key(first_itinerary.state).to_s[0...2]
  end

  # sets the state name to a string of max_length chars, padded by zeros if necessary
  def get_truncated_city_name(first_itinerary, state)
    max_length = (state.length == 1 ? 5 : 6)
    city_name = first_itinerary.city
    city_name = city_name.delete(" ")[0...max_length]
    city_name += '0' while city_name.length < max_length
    return city_name
  end

  # returns the date of the first travel itinerary parsed as mmddyyyy
  def get_date(first_itinerary)
    first_itinerary.date.strftime('%m%d%Y')
  end
end

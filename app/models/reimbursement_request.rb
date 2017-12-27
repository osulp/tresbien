# frozen_string_literal: true
require 'fileutils'

class ReimbursementRequest < ApplicationRecord
  scope :user_claimant_requests, ->(user_id) { where claimant_id: user_id }
  scope :user_certifier_requests, ->(user_id) { where certifier_id: user_id }
  belongs_to :claimant, class_name: 'User'
  belongs_to :certifier, class_name: 'User'
  belongs_to :description
  has_many :accountings
  has_many :expense_airfares
  has_many :expense_mileages
  has_many :expense_others
  has_many :travel_cities
  has_many :travel_itineraries
  has_many :attachments
  accepts_nested_attributes_for :accountings, :expense_airfares, :expense_mileages, :expense_others, :travel_itineraries, :travel_cities, allow_destroy: true
  validates :certifier_id, presence: true
  validate :includes_travel_itinerary
  validate :includes_accounting
  validates :business_notes_and_purpose, length: { maximum: 250 }
  validates :description_id, presence: true

  before_create :generate_identifier
  before_save :calculate_grand_total

  # The set_defaults will only work if the object is new
  after_initialize :set_defaults, unless: :persisted?

  # Calculate the grand total for the reimbursement request
  def calculate_grand_total
    self.airfare_total = get_total_sum(expense_airfares)
    self.mileage_total = get_total_sum(expense_mileages)
    self.itinerary_total = get_total_sum(travel_itineraries)
    self.other_total = get_total_sum(expense_others)
    self.grand_total = [airfare_total, mileage_total, other_total, itinerary_total].sum
  end

  # returns the reimbursement request's travel itineraries sorted by date
  def get_first_travel_itinerary
    travel_itineraries.to_a.sort_by!(&:date).first
  end

  def export_as_banner_csv
    path = get_or_create_banner_data_file_path
    File.open(File.join(path, "#{identifier}.csv"), 'w+') do |f|
      accountings.each do |a|
        line = sprintf('%<vendor_id>s,%<identifier>s,%<vendor_payment_address>s,%<invoice_date>s,%<discount_code>s,%<index_code>s,%<fund_code>s,%<account_code>s,%<activity_code>s,"%<description>s",%<amount>.2f,%<discount_amount>s',
          get_banner_data_for_account(a))
        f.puts line
      end
    end
  end

  private

  def get_or_create_banner_data_file_path
    banner_csv_file_dirname = File.expand_path(ENV['BANNER_CSV_FILE_PATH'])
    unless File.directory? banner_csv_file_dirname
      FileUtils.mkdir_p banner_csv_file_dirname
    end
    banner_csv_file_dirname
  end

  ##
  # Generate the proper data for an account line in the CSV export. Business rules expressed;
  # 1. An exported line should have either index and account code OR fund and account but not both index & fund with the account.
  # 2. Prefer exporting index and account (reimbursement style) vs fund and account (travel advance style)
  # 3. Discount code is purposefully hardcoded to 19 for Banner import loader compatibility
  def get_banner_data_for_account(a)
    {
      vendor_id: claimant.osu_id,
      vendor_payment_address: claimant.organization.vendor_payment_address,
      identifier: identifier,
      invoice_date: get_first_travel_itinerary.date.strftime('%d-%^b-%Y'),
      index_code: a.index,
      fund_code: a.index.empty? ? a.fund : '',
      account_code: a.account,
      activity_code: a.activity,
      description: description.name,
      amount: a.amount,
      discount_amount: '',
      discount_code: '19'
    }
  end

  def set_defaults
    self.status ||= 'draft'
  end

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
    max_length = (state.length == 1 ? 6 : 5)
    city_name = first_itinerary.city
    city_name = city_name.delete(' ')[0...max_length]
    city_name += '0' while city_name.length < max_length
    city_name
  end

  # returns the date of the first travel itinerary parsed as mmddyyyy
  def get_date(first_itinerary)
    first_itinerary.date.strftime('%m%d%Y')
  end

  def includes_travel_itinerary
    errors.add(:base, 'Must have at least one daily itinerary.', target_nav_panel_href: 'itinerary_panel') if travel_itineraries.empty? || travel_itineraries.all?(&:marked_for_destruction?)
  end

  def includes_accounting
    errors.add(:base, 'Must have at least one accounting record.', target_nav_panel_href: 'accounting_panel') if accountings.empty? || accountings.all?(&:marked_for_destruction?)
  end
end

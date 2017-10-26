class ApplicationConfiguration < ApplicationRecord
  scope :contact_email, -> { where(name: 'Contact Email') }
  scope :mileage_rate, -> { where(name: 'Mileage Rate') }

  validates :name, :value, presence: true
end

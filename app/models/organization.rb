# frozen_string_literal: true

class Organization < ApplicationRecord
  scope :active, -> { where(active: true) }
  has_many :users

  validates :name, uniqueness: true
  validates :organization_code, presence: true
  validates :program_code, presence: true
  validates :fund, presence: true
  validates :vendor_payment_address, presence: true
end

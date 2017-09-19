# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :users
  validates :organization_code, presence: true
  validates :program_code, presence: true
end

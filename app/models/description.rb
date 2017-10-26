# frozen_string_literal: true

class Description < ApplicationRecord
  has_many :reimbursement_requests
  scope :active, -> { where(active: true) }

  validates :name, uniqueness: true
  validates :name, presence: true, length: { maximum: 50 }
end

class AccountCode < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, :code, presence: true
end

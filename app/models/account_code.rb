class AccountCode < ApplicationRecord
  validates :name, :code, presence: true
end

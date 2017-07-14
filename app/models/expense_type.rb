class ExpenseType < ApplicationRecord
  scope :active, -> { where(active:true) }
  validates :name, presence:true
end

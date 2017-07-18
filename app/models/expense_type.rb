class ExpenseType < ApplicationRecord
  scope :active, -> { where(active:true) }
  validates :name, presence:true
  has_many :expense_others
end

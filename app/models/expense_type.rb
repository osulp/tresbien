class ExpenseType < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :above_per_diem, -> { where(name: 'Above Per Diem') }
  scope :not_above_per_diem, -> { where.not(name: 'Above Per Diem') }
  validates :name, presence:true
  has_many :expense_others
end

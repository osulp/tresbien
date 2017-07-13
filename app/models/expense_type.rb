class ExpenseType < ApplicationRecord
  scope :active, -> { where(active:true) }
  validates :form, presence:true
end

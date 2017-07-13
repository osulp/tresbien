class ExpenseType < ApplicationRecord
  scope :active, -> { where(active:true) }
end

class ExpenseOther < ApplicationRecord
  belongs_to :reimbursement_request
  has_one :ExpenseType
end

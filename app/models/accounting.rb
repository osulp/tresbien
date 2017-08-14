class Accounting < ApplicationRecord
  belongs_to :reimbursement_request
  validates :index, :fund, :organization, :account, :program, :activity, :amount, presence: true
end

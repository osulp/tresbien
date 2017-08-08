class Status < ApplicationRecord
  has_many :reimbursement_requests, :inverse_of => :status
  validates :name, presence: true

end

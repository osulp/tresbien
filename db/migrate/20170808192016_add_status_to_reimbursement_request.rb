class AddStatusToReimbursementRequest < ActiveRecord::Migration[5.1]
  def change
    add_reference  :reimbursement_requests, :status, foreign_key: true
  end
end

class AddStatusStringToReimbursementRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :reimbursement_requests, :status, :string
  end
end

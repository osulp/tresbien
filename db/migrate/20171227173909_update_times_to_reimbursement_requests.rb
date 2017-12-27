class UpdateTimesToReimbursementRequests < ActiveRecord::Migration[5.1]
  def change
    change_column :reimbursement_requests, :depart_time, :string
    change_column :reimbursement_requests, :return_time, :string
  end
end

class AddDepartTimeAndReturnTimeToReimbursementRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :reimbursement_requests, :depart_time, :time
    add_column :reimbursement_requests, :return_time, :time
  end
end

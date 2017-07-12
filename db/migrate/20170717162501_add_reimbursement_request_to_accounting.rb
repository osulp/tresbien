class AddReimbursementRequestToAccounting < ActiveRecord::Migration[5.1]
  def change
    add_reference :accountings, :reimbursement_request, foreign_key: true
  end
end

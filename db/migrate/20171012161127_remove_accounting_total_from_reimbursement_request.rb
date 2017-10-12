class RemoveAccountingTotalFromReimbursementRequest < ActiveRecord::Migration[5.1]
  def change
    remove_column :reimbursement_requests, :accounting_total
  end
end

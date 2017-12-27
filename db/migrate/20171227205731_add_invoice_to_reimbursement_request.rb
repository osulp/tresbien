class AddInvoiceToReimbursementRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :reimbursement_requests, :invoice_number, :string
  end
end

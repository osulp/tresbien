class AddBusinessNotesAndAddressToReimbursementRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :reimbursement_requests, :business_notes_and_purpose, :text
    add_column :reimbursement_requests, :address, :string
  end
end

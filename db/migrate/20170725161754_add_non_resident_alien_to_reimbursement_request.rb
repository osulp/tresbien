class AddNonResidentAlienToReimbursementRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :reimbursement_requests, :non_resident_alien, :boolean
  end
end

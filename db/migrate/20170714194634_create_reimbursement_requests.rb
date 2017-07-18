class CreateReimbursementRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :reimbursement_requests do |t|
      # t.references :claimant, foreign_key: true
      # t.references :certifier, foreign_key: true
      # t.references :users, foreign_key: { name: 'claimant_id' }, index: { name: 'index_reimbursement_requests_on_users_id_claimant' }
      # t.references :users, foreign_key: { name: 'certifier_id' }, index: { name: 'index_reimbursement_requests_on_users_id_certifier' }
      t.string :identifier
      t.text :description
      t.float :itinerary_total
      t.float :mileage_total
      t.float :airfare_total
      t.float :other_total
      t.float :accounting_total
      t.float :grand_total
      t.float :claiming_total

      t.timestamps
    end
    add_reference(:reimbursement_requests, :claimant, foreign_key: { to_table: :users })
    add_reference(:reimbursement_requests, :certifier, foreign_key: { to_table: :users })
  end
end

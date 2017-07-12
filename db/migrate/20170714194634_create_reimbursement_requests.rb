class CreateReimbursementRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :reimbursement_requests do |t|
      t.references :claimant, foreign_key: true
      t.references :certifier, foreign_key: true
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
  end
end

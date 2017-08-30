class CreateStatusComments < ActiveRecord::Migration[5.1]
  def change
    create_table :status_comments do |t|
      t.text :comment
      t.references :reimbursement_request, foreign_key: true

      t.timestamps
    end
  end
end

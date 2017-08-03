class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.attachment :attachment
    end
    add_reference :attachments, :reimbursement_request, foreign_key: true
  end
end

# frozen_string_literal: true

class DeleteStatuses < ActiveRecord::Migration[5.1]
  def change
    remove_index :reimbursement_requests, :status_id
    drop_table :statuses
  end
end

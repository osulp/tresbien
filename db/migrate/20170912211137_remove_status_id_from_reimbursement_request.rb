# frozen_string_literal: true

class RemoveStatusIdFromReimbursementRequest < ActiveRecord::Migration[5.1]
  def change
    remove_column :reimbursement_requests, :status_id
  end
end

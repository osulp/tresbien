# frozen_string_literal: true

class ChangeDescriptionInReimbursementRequest < ActiveRecord::Migration[5.1]
  def change
    remove_column :reimbursement_requests, :description
    add_reference :reimbursement_requests, :description, foreign_key: true
  end
end

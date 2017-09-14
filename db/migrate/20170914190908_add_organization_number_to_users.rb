# frozen_string_literal: true

class AddOrganizationNumberToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :organization_id, :integer
    add_reference(:users, :organizations, foreign_key: true)
  end
end

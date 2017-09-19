# frozen_string_literal: true

class CreateOrganization < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :organization_code
      t.string :program_code
    end
  end
end

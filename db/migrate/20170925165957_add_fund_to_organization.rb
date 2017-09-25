class AddFundToOrganization < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :fund, :string
  end
end

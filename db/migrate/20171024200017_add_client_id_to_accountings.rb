class AddClientIdToAccountings < ActiveRecord::Migration[5.1]
  def change
    add_column :accountings, :client_id, :string
  end
end

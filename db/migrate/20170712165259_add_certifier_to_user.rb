class AddCertifierToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :certifier, :boolean, default: false
  end
end

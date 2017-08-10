class AddIndexCodeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :index_code, :integer
  end
end

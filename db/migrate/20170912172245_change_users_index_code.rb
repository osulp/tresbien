class ChangeUsersIndexCode < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :index_code, :activity_code
  end
end

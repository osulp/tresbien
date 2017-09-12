class ChangeUsersActivityCode < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :activity_code, :string
  end
end

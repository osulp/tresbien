class AddPidmToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :pidm, :integer
  end
end

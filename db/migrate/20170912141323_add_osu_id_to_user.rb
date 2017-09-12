class AddOsuIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :osu_id, :string
  end
end

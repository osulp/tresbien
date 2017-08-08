class AddOrderToStatuses < ActiveRecord::Migration[5.1]
  def change
    add_column :statuses, :order, :integer
  end
end

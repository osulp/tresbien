class AddMileageRateToExpenseMileage < ActiveRecord::Migration[5.1]
  def change
    add_column :expense_mileages, :mileage_rate, :float
  end
end

class AddAbovePerDiemExpenseToExpenseOthers < ActiveRecord::Migration[5.1]
  def change
    add_column :expense_others, :above_per_diem_expense, :boolean, default: :false
  end
end

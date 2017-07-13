class UpdatesActiveForExpenseTypes < ActiveRecord::Migration[5.1]
  def change
    change_column_default :expense_types, :active,  from: false, to: true
  end
end

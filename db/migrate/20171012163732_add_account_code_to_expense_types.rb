class AddAccountCodeToExpenseTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :expense_types, :account_code, :string
  end
end

class CreateExpenseOthers < ActiveRecord::Migration[5.1]
  def change
    create_table :expense_others do |t|
      t.belongs_to :expense_type, index: true
      t.datetime :from_date
      t.datetime :to_date
      t.text :notes
      t.float :amount

      t.timestamps
    end
  end
end

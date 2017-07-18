class CreateExpenseAirfares < ActiveRecord::Migration[5.1]
  def change
    create_table :expense_airfares do |t|
      t.datetime :from_date
      t.datetime :to_date
      t.string :from_location
      t.string :to_location
      t.text :notes
      t.float :amount

      t.timestamps
    end
  end
end

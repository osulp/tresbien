class CreateExpenseMileages < ActiveRecord::Migration[5.1]
  def change
    create_table :expense_mileages do |t|
      t.datetime :from_date
      t.datetime :to_date
      t.string :from_city
      t.string :from_state
      t.string :to_city
      t.string :to_state
      t.integer :miles
      t.boolean :round_trip
      t.text :notes
      t.float :amount

      t.timestamps
    end
  end
end

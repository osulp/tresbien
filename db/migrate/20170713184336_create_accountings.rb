class CreateAccountings < ActiveRecord::Migration[5.1]
  def change
    create_table :accountings do |t|
      t.string :index
      t.string :fund
      t.string :organization
      t.string :account
      t.string :program
      t.string :activity
      t.float :amount

      t.timestamps
    end
  end
end

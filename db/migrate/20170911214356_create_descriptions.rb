class CreateDescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :descriptions do |t|
      t.string :name
      t.boolean :active
    end
  end
end

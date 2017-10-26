class CreateApplicationConfigurations < ActiveRecord::Migration[5.1]
  def change
    create_table :application_configurations do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end

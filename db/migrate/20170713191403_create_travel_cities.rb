class CreateTravelCities < ActiveRecord::Migration[5.1]
  def change
    create_table :travel_cities do |t|
      t.datetime :from_date
      t.datetime :to_date
      t.string :city
      t.string :state
      t.boolean :include_meals
      t.string :hotel_rate

      t.timestamps
    end
  end
end

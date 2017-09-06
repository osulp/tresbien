class AddMealsToTravelCities < ActiveRecord::Migration[5.1]
  def change
    add_column :travel_cities, :meals, :string
  end
end

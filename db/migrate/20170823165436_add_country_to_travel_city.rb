class AddCountryToTravelCity < ActiveRecord::Migration[5.1]
  def change
    add_column :travel_cities, :country, :string
  end
end

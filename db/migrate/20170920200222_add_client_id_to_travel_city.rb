class AddClientIdToTravelCity < ActiveRecord::Migration[5.1]
  def change
    add_column :travel_cities, :client_id, :string
  end
end

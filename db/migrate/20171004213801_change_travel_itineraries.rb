class ChangeTravelItineraries < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :travel_itineraries, :break, :breakfast
  end
  def self.down
    rename_column :travel_itineraries, :breakfast, :break
  end
end

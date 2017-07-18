class CreateTravelItineraries < ActiveRecord::Migration[5.1]
  def change
    create_table :travel_itineraries do |t|
      t.datetime :date
      t.string :city
      t.string :state
      t.string :break
      t.string :lunch
      t.string :dinner
      t.string :hotel
      t.float :amount

      t.timestamps
    end
  end
end

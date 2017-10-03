require 'spec_helper'
require 'rails_helper'

RSpec.describe TravelItinerary, type: :model do
  let(:travel_itinerary) { TravelItinerary.new(date: Date.today, break: 10, lunch: 10, dinner: 20, hotel: 100, per_diem: 120, city: 'Las Vegas', state: 'NV', country: 'United States' ) { |t| t.save!(validate: false) } }
  let(:label) { 'Las Vegas, NV (United States)' }

  it 'has a location label' do
    expect(travel_itinerary.location_label).to eq label
  end
end

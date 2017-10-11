require 'spec_helper'
require 'rails_helper'

RSpec.describe ReimbursementRequest, type: :model do
  let(:user) do
    User.new(email: 'test@example.com', full_name: 'Bob Ross', admin: false) { |u| u.save!(validate: false) }
  end
  let(:travel_city) { TravelCity.new(from_date: Date.today, to_date: Date.today, hotel_rate: 100, city: 'Las Vegas', state: 'NV') { |t| t.save!(validate: false) } }
  let(:travel_itinerary) { TravelItinerary.new(date: Date.today, breakfast: 10, lunch: 10, dinner: 20, hotel: 100, per_diem: 120, city: 'Las Vegas', state: 'NV' ) { |t| t.save!(validate: false) } }
  let(:description) { Description.create(name: 'Bob Ross was the best ever.', active: true) }
  let(:reimbursement_request) do
    ReimbursementRequest.create(
      claimant: user,
      certifier: user,
      description: description,
      travel_cities: [travel_city],
      travel_itineraries: [travel_itinerary])
  end

  it 'includes a travel city' do
    reimbursement_request.validate!
    expect(reimbursement_request.errors.full_messages.length).to eq 0
  end
end

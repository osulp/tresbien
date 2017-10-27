require 'spec_helper'
require 'rails_helper'

RSpec.describe ReimbursementRequest, type: :model do
  let(:organization) { Organization.new(vendor_payment_address: 'VP/1', organization_code: 'blah', program_code: 'blah', name: 'org', fund: 'blahblah') { |t| t.save!(validate: false) } }
  let(:user) do
    User.new(email: 'test@example.com', full_name: 'Bob Ross', admin: false, osu_id: '123412341', organization: organization) { |u| u.save!(validate: false) }
  end
  let(:travel_city) { TravelCity.new(from_date: Date.today, to_date: Date.today, hotel_rate: 100, city: 'Las Vegas', state: 'NV') { |t| t.save!(validate: false) } }
  let(:accounting) { Accounting.new(index: '123', fund: '123', organization: '123', account: '123', program: '123', activity: '123', amount: 123 ) { |a| a.save!(validate: false) } }
  let(:travel_itinerary) { TravelItinerary.new(date: Date.today, break: 10, lunch: 10, dinner: 20, hotel: 100, per_diem: 150, city: 'Las Vegas', state: 'NV' ) { |t| t.save!(validate: false) } }
  let(:description) { Description.create(name: 'Bob Ross was the best ever.', active: true) }
  let(:reimbursement_request) do
    ReimbursementRequest.create(
      claimant: user,
      certifier: user,
      description: description,
      accountings: [accounting],
      travel_cities: [travel_city],
      travel_itineraries: [travel_itinerary])
  end

  it 'includes a travel city and an accounting line' do
    reimbursement_request.validate!
    expect(reimbursement_request.errors.full_messages.length).to eq 0
  end

  context 'with an expense above per diem' do
    let(:travel_itinerary) { TravelItinerary.new(date: Date.today, break: 10, lunch: 10, dinner: 20, hotel: 100, per_diem: 10, city: 'Las Vegas', state: 'NV' ) { |t| t.save!(validate: false) } }
    it 'fails validation' do
      expect {reimbursement_request.validate!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'exporting banner csv' do
    it 'writes a file' do
      expect { reimbursement_request.export_as_banner_csv }.to_not raise_error
    end
  end
end

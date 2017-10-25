require 'spec_helper'
require 'rails_helper'

RSpec.describe ReimbursementRequestHelper, type: :helper do
  let(:user) do
    User.new(email: 'test@example.com', full_name: 'Bob Ross', admin: false) { |u| u.save!(validate: false) }
  end
  let(:claimant) { user }
  let(:certifier) { user }
  let(:travel_city) { TravelCity.new(from_date: Date.today, to_date: Date.today, hotel_rate: 100, city: 'Las Vegas', state: 'NV', country: 'United States') { |t| t.save!(validate: false) } }
  let(:travel_itinerary) { TravelItinerary.new(date: Date.today, break: 10, lunch: 10, dinner: 20, hotel: 100, per_diem: 140, city: 'Las Vegas', state: 'NV', country: 'United States' ) { |t| t.save!(validate: false) } }
  let(:description) { Description.create(name: 'Bob Ross was the best ever.', active: true) }
  let(:accounting) { Accounting.create(index: 'abc', fund: 'abc', organization: 'abc', account: 'abc', program: 'abc', activity: 'abc', amount: 123) { |a| a.save!(validate: false) } }
  let(:reimbursement_request) do
    ReimbursementRequest.create(
      claimant: claimant,
      certifier: certifier,
      description: description,
      travel_cities: [travel_city],
      travel_itineraries: [travel_itinerary],
      accountings: [accounting])
  end

  before do
    allow(helper).to receive(:current_user).and_return(user)
  end

  describe '#get_request_title' do
    let(:title) { "#{Date.today.strftime('%e %B %Y')}: Las Vegas, NV  (US)" }
    it 'returns a formatted request title' do
      expect(helper.get_request_title(reimbursement_request)).to eq title
    end
  end

  describe '#get_simple_date' do
    let(:expected) { Date.today.strftime('%m/%d/%y') }
    it 'returns a simple formatted date' do
      expect(helper.get_simple_date(Date.today)).to eq expected
    end
  end

  describe '#get_table_row_class' do
    it 'returns claimant certifier class string' do
      expect(helper.get_table_row_class(reimbursement_request)).to eq 'draft claimant certifier '
    end
    context 'when the user is the certifier and not the claimant' do
      let(:claimant) { User.new { |u| u.save!(validate: false) } }
      it 'returns a draft class string' do
        expect(helper.get_table_row_class(reimbursement_request)).to eq 'draft certifier '
      end
    end
    context 'when the user is the claimant and not the certifier' do
      let(:certifier) { User.new { |u| u.save!(validate: false) } }
      it 'returns a draft class string' do
        expect(helper.get_table_row_class(reimbursement_request)).to eq 'draft claimant '
      end
    end
    context 'when the user is neither the claimant nor the certifier' do
      let(:certifier) { User.new(email: 'bob@bob.ross') { |u| u.save!(validate: false) } }
      let(:claimant) { User.new(email: 'bobs-paintbrush@bob.ross') { |u| u.save!(validate: false) } }
      it 'returns a draft class string' do
        expect(helper.get_table_row_class(reimbursement_request)).to eq 'draft other-user '
      end
    end
  end

  describe '#get_status_icon' do
    it 'returns a default icon class' do
      expect(helper.get_status_icon('')).to eq 'fa-shower'
    end
    it 'returns a draft icon class' do
      expect(helper.get_status_icon('draft')).to eq 'fa-pencil-square-o'
    end
    it 'returns a submitted icon class' do
      expect(helper.get_status_icon('submitted')).to eq 'fa-dot-circle-o'
    end
    it 'returns an approved icon class' do
      expect(helper.get_status_icon('approved')).to eq 'fa-check-circle-o'
    end
    it 'returns a declined icon class' do
      expect(helper.get_status_icon('declined')).to eq 'fa-times-circle-o'
    end
  end

  describe '#new_record_class' do
    it 'returns the an empty class name for created requests' do
      expect(helper.new_record_class(reimbursement_request)).to eq ''
    end
    context 'with a new record' do
      let(:reimbursement_request) do
        ReimbursementRequest.new(
          claimant: claimant,
          certifier: certifier,
          description: description,
          travel_cities: [travel_city],
          travel_itineraries: [travel_itinerary])
      end
      it 'returns the class name' do
        expect(helper.new_record_class(reimbursement_request)).to eq 'new-record'
      end
    end
  end
  describe '#claimant_name' do
    let(:claimant) do
      User.new(email: 'test2@example.com', full_name: 'Ronald Jenkees', admin: false) { |u| u.save!(validate: false) }
    end
    it 'returns the claimants name for created requests' do
      expect(helper.claimant_name(reimbursement_request)).to eq claimant.full_name
    end
    context 'with a new record' do
      let(:reimbursement_request) do
        ReimbursementRequest.new(
          claimant: claimant,
          certifier: certifier,
          description: description,
          travel_cities: [travel_city],
          travel_itineraries: [travel_itinerary])
      end
      it 'returns the class name' do
        expect(helper.claimant_name(reimbursement_request)).to eq user.full_name
      end
    end
  end
end

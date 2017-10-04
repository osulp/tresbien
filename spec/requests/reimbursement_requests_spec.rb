require 'rails_helper'

RSpec.describe "ReimbursementRequests", type: :request do
  let(:org) { Organization.new() }
  let(:user_admin) { User.new(osu_id: "111111", activity_code: "222", organization: org)}
  describe "test" do
    it "creates a reimbursement request" do
      rr = create(:reimbursement_request)
      expect(rr.travel_cities.count).to eq 1
    end
  end
  describe "GET /reimbursement_requests" do
    it "redirects to root path" do

    end
  end
end

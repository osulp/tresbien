require 'rails_helper'

RSpec.describe "ReimbursementRequests", type: :request do
  let(:org) { Organization.new() }
  let(:user_admin) { User.new(osu_id: "111111", activity_code: "222", organization: org)}
  describe "GET /reimbursement_requests" do
    context "when not logged in" do
      it "redirects to login" do
        get new_reimbursement_request_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

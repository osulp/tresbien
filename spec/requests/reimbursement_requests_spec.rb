require 'rails_helper'

RSpec.describe "ReimbursementRequests", type: :request do
  before(:each) do
    @user = build :user
    login_as(@user, :scope => :user)
  end
  describe "GET /reimbursement_requests" do
    it "redirects to root path" do
      get reimbursement_requests_path
      expect(request).to redirect_to(root_path)
    end
  end
  describe "POST /reimbursement_requests/new" do
    it "redrects to show after creation" do
      # login_as @user, :scope => :user
      # rr_attributes = attributes_for(:reimbursement_request)
      rr = build(:reimbursement_request)
      rr_attributes = rr.attributes.except('created_at', 'updated_at')
      post reimbursement_requests_path, params: { reimbursement_request: rr_attributes }
      expect(response).to redirect_to reimbursement_requests_path(rr)

    end
  end
end

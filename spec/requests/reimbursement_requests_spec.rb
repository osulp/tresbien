require 'rails_helper'

RSpec.describe "ReimbursementRequests", type: :request do
  before(:all) do
    @user = create :user
    login_as(@user, :scope => :user)
  end
  describe "GET /reimbursement_requests" do
    it "redirects to root path" do
      get reimbursement_requests_path
      expect(request).to redirect_to(root_path)
    end
  end
  describe "GET /reimbursement_requests/new" do
    it "renders new template" do
      post reimbursement_requests_path, params: attributes_for(:reimbursement_request)

    end
  end
end

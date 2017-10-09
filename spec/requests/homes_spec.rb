require 'rails_helper'

RSpec.describe "Home", type: :request do
  let(:org) { Organization.new() }
  let(:user_admin) { User.new(osu_id: "111111", activity_code: "222", organization: org)}
  describe "GET index" do
    context "when not logged in" do
      # it "redirects to login" do
      #   get root_path
      #   expect(response).to redirect_to new_user_session_path
      # end
    end
    context "when logged in with required fields compelete" do
      # before do
      #   login_as user_admin
      # end
      # it "does not redirect user" do
      #   get root_path
      #   expect(response).to_not redirect_to new_user_session_path
      # end
    end
  end
end

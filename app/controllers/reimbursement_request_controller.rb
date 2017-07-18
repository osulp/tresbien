class ReimbursementRequestController < ApplicationController
  def new
    @reimbursement_request = ReimbursementRequest.new
  end
end

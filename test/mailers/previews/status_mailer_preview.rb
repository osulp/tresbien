require 'test_helper'

class StatusMailerPreview < ActionMailer::Preview
  def approve_request
    StatusMailer.approve_request(ReimbursementRequest.last)
  end

  def decline_request
    StatusMailer.decline_request(ReimbursementRequest.last)
  end

  def submit_request
    StatusMailer.submit_request(ReimbursementRequest.last)
  end

  def certify_request
   StatusMailer.certify_request(ReimbursementRequest.last)
  end

  def resubmit_request
   StatusMailer.resubmit_request(ReimbursementRequest.last)
  end

end

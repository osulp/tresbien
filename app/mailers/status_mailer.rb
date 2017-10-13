class StatusMailer < ApplicationMailer
  default from: 'noreply@oregonstate.edu'

  def approve_request(reimbursement_request)
    @reimbursement_request = reimbursement_request
    @claimant = reimbursement_request.claimant
    @certifier = reimbursement_request.certifier
    @status = reimbursement_request.status
    mail(to: @claimant.email, subject: 'Your Reimbursement Request has been approved')
  end

  def certify_request(reimbursement_request)
    @reimbursement_request = reimbursement_request
    @claimant = reimbursement_request.claimant
    @certifier = reimbursement_request.certifier
    @status = reimbursement_request.status
    mail(to: @certifier.email, subject: 'Reimbursement request is ready for approval')
  end

  def decline_request(reimbursement_request)
    @reimbursement_request = reimbursement_request
    @claimant = reimbursement_request.claimant
    @certifier = reimbursement_request.certifier
    @status = reimbursement_request.status
    mail(to: @claimant.email, subject: 'Your Reimbursement Request has been Denied')
  end

  def resubmit_request(reimbursement_request)
    @reimbursement_request = reimbursement_request
    @claimant = reimbursement_request.claimant
    @certifier = reimbursement_request.certifier
    @status = reimbursement_request.status
    mail(to: @certifier.email, subject: 'Reimbursement Request Re-Submitted')
  end

  def submit_request(reimbursement_request)
    @reimbursement_request = reimbursement_request
    @claimant = reimbursement_request.claimant
    @certifier = reimbursement_request.certifier
    @status = reimbursement_request.status
    mail(to: @claimant.email, subject: "Your reimbursement request has been submitted")
  end
end

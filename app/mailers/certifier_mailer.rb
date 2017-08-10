class CertifierMailer < ApplicationMailer

  def certify_request(reimbursement_request)
    @reimbursement_request = reimbursement_request
    @claimant = @reimbursement_request.claimant


    mail to: @claimant.email, subject: "certify this request"
  end
end

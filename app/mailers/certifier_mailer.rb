class CertifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.certifier_mailer.certify_request.subject
  #
  def certify_request(reimbursement_request)
    @reimbursement_request = reimbursement_request
    @claimant = @reimbursement_request.claimant


    mail to: @claimant.email, subject: "certify this request"
  end
end

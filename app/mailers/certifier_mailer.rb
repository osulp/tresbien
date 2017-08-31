# frozen_string_literal: true

class CertifierMailer < ApplicationMailer
  default from: 'noreply@oregonstate.edu'

  def certify_request(reimbursement_request)
    @certifier = reimbursement_request.certifier
    @reimbursement_request = reimbursement_request
    mail(to: @certifier.email, subject: 'A reimbursement request is ready to be certified')
  end
end

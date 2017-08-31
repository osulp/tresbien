class DeclinedMailer < ApplicationMailer
  default from: 'noreply@oregonstate.edu'


  def decline_request(reimbursement_request)
    @certifier = reimbursement_request.certifier
    @reimbursement_request = reimbursement_request
    mail(to: @certifier.email, subject: 'certify this request')
  end
end
end

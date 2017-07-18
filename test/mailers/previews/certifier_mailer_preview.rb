# Preview all emails at http://localhost:3000/rails/mailers/certifier_mailer
class CertifierMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/certifier_mailer/certify_request
  def certify_request
    reimbursement_request = ReimbursementRequest.last
    CertifierMailer.certify_request(reimbursement_request)
  end

end

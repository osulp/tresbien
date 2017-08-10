require 'test_helper'

class CertifierMailerTest < ActionMailer::TestCase
  test "certify_request" do
    mail = CertifierMailer.certify_request
    assert_equal "Certify request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

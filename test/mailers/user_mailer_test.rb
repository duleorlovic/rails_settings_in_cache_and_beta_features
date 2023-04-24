require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "sample" do
    mail = UserMailer.sample
    assert_equal "Sample", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["support@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

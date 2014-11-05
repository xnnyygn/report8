require 'test_helper'

class CorrectionNotifierTest < ActionMailer::TestCase

  test "received" do
    mail = CorrectionNotifier.received(users(:xy), users(:admin), reports(:one))
    assert_equal "You got new corrections", mail.subject
    assert_equal ["xy@report8.com"], mail.to
    assert_equal ["noreply@report8.com"], mail.from
    assert_match /one/, mail.body.encoded
  end

end

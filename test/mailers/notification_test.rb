require 'test_helper'

class NotificationTest < ActionMailer::TestCase
  test "room_authorization" do
    mail = Notification.room_authorization
    assert_equal "Room authorization", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

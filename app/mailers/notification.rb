class Notification < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.room_authorization.subject
  #
  def room_authorization
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end

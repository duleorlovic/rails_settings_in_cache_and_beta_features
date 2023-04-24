class UserMailer < ApplicationMailer
  def sample
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end

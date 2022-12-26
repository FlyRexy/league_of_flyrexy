class UserMailer < ApplicationMailer
  default from: "flyrexy.app@gmail.com"

  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.login} <#{user.email}>", subject: "Подтверждение регистрации")
  end
end

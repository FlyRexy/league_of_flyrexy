class PasswordResetMailer < ApplicationMailer
  default from: "flyrexy.app@gmail.com"

  def password_reset(user)
    @user = user
    mail(to: "#{user.login} <#{user.email}>", subject: "Изменение пароля")
  end
end

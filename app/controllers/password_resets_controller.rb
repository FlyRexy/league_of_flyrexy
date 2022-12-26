# frozen_string_literal: true

# control all actions with resetting password
class PasswordResetsController < ApplicationController
  before_action :authorized
  before_action :set_user, only: %i[edit update]

  def new; end

  def create
    @user = User.find_by_email(params[:email])
    if @user.present?
      @user.set_reset_password_token
      PasswordResetMailer.password_reset(@user).deliver_later
    end
    redirect_to new_session_path, notice: 'Проверьте свою почту для сброса пароля'
  end

  def edit; end

  def update
    return unless @user.update(user_params)

    redirect_to new_session_path, notice: 'Успешное изменение пароля'
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation).merge(old_password_needs: false)
  end

  def set_user
    unless params[:user][:email].present?
      redirect_to new_session_path,
                  notice: 'Ссылка оказалась неправильной' and return
    end

    @user = User.find_by(email: params[:user][:email], password_reset_token: params[:user][:password_reset_token])
    return if @user&.password_reset_period_valid?

    redirect_to new_session_path,
                notice: 'Не удалось найти пользователя, либо срок действия ссылки истек'
  end
end

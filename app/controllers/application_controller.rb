# frozen_string_literal: true

# control of common functions
class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def user_signed_in?
    current_user.present?
  end

  def access
    return if user_signed_in?

    redirect_to root_path, notice: 'Вы не авторизованы'
  end

  def admin
    return if current_user&.email == 'eferovnik@mail.ru'

    redirect_to root_path, notice: 'Бро, это не твоя территория 🐣'
  end

  def authorized
    return unless user_signed_in?

    redirect_to root_path, notice: 'Вы уже авторизованы'
  end

  helper_method :current_user, :user_signed_in?
end

# frozen_string_literal: true

# control users sessions
class SessionsController < ApplicationController
  before_action :access, only: :destroy
  before_action :authorized, only: %i[new create]
  def new; end

  def create
    user = User.find_by_login(params[:login])
    if user&.authenticate(params[:password])
      # if user.email_confirmed
      #   session[:user_id] = user.id
      #   redirect_to root_path
      # else
      #   redirect_to root_path, notice: 'Пожалуйста, подтвердите адрес эл. почты'
      # end
    else
      redirect_to new_session_path, notice: 'Неправильный логин и/или пароль'
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end
end

# frozen_string_literal: true

# controller for users and their actions
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :access, only: %i[show edit update destroy]
  before_action :authorized, only: %i[new create]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    return unless @user.save

    UserMailer.registration_confirmation(@user).deliver_later
    # session[:user_id] = @user.id
    redirect_to root_path, notice: 'Подтвердите свой адрес электронной почты, чтобы продолжить изучать мир
       киберспорта со всеми возможностями'
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_path, notice: 'Данные о пользователе были обновлены' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :update }
        format.turbo_stream { render :update }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      redirect_to new_session_path, notice: 'Добро пожаловать! Пожалуйста, войдите в свой аккаунт'
    else
      redirect_to new_user_path, notice: 'К сожалению, такого пользователя не существует🙈'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :login, :password, :password_confirmation, :favorite,
                                 :old_password).merge(old_password_needs: true)
  end
end

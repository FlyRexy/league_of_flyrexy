# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'signing user', type: :system do
  scenario 'signing in' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    visit new_session_path

    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click

    sleep(1)

    expect(current_path).to eq root_path
  end

  scenario 'signing up' do
    visit new_user_path

    user = User.new(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                    password_confirmation: 'testPassword21')

    fill_in 'user_email', with: user.email
    fill_in 'user_password_confirmation', with: user.password_confirmation
    fill_in 'user_login', with: user.login
    fill_in 'user_password', with: user.password

    find('#my_reg_button').click

    expect(page).to have_text('Подтвердите свой адрес электронной почты, чтобы продолжить изучать мир киберспорта со всеми возможностями')
  end
end

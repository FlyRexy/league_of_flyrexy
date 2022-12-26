# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user trying to get he should not be', type: :feature do
  scenario 'user is trying to log in again' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    visit new_session_path


    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click
    sleep(1)

    visit new_session_path

    expect(page).to have_text 'Вы уже авторизованы'
  end
  scenario 'user is trying to sign up again' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    visit new_session_path


    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click
    sleep(1)

    visit new_user_path

    expect(page).to have_text 'Вы уже авторизованы'
  end
end

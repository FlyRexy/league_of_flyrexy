# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'editing user data', type: :system do
  scenario 'change password' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    visit new_session_path


    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click
    sleep(1)
    new_password = 'Awesome12'

    visit current_path
    find('#navbarDarkDropdownMenuLink').click
    find('#edit_button_header').click
    fill_in 'user_old_password', with: user.password
    fill_in 'user_password', with: new_password
    fill_in 'user_password_confirmation', with: new_password

    find('#edit_user_button').click

    expect(page).to have_text 'Данные о пользователе были обновлены'
  end
  scenario 'change password with incorrect old password' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    visit new_session_path

    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click

    sleep(1)

    new_password = 'Awesome12'
    invalid_password = 'Hahahaha1'

    visit current_path
    find('#navbarDarkDropdownMenuLink').click
    find('#edit_button_header').click
    fill_in 'user_old_password', with: invalid_password
    fill_in 'user_password', with: new_password
    fill_in 'user_password_confirmation', with: new_password

    find('#edit_user_button').click

    expect(page).to have_text 'Старый пароль был введен неправильно!🐨'
  end
  scenario 'change login w/o updating password' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    visit new_session_path

    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click

    sleep(1)

    new_login = 'SomethingUnique'

    visit current_path
    find('#navbarDarkDropdownMenuLink').click
    find('#edit_button_header').click
    fill_in 'user_login', with: new_login

    find('#edit_user_button').click

    sleep(1)

    expect(page).to have_text 'Данные о пользователе были обновлены'
  end
  scenario 'change email w/o updating password' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    visit new_session_path

    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click

    sleep(1)

    new_email = 'cool.unique@gmail.com'

    visit current_path
    find('#navbarDarkDropdownMenuLink').click
    find('#edit_button_header').click
    fill_in 'user_email', with: new_email

    find('#edit_user_button').click

    sleep(1)

    expect(page).to have_text 'Данные о пользователе были обновлены'
  end
end
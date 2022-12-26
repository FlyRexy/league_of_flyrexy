# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user trying to get he should not be', type: :feature do
  scenario 'user getting to adding new teams' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    visit new_session_path


    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click
    sleep(1)

    visit new_teams_path

    expect(page).to have_text 'Бро, это не твоя территория 🐣'
  end
  scenario 'user getting to update ru' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    visit new_session_path


    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click
    sleep(1)

    visit matches_update_ru_path

    expect(page).to have_text 'Бро, это не твоя территория 🐣'
  end
  scenario 'user getting to update eu' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    visit new_session_path


    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click
    sleep(1)

    visit matches_update_eu_path

    expect(page).to have_text 'Бро, это не твоя территория 🐣'
  end
end

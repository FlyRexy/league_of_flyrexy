# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'favorite page', type: :system do
  scenario 'adding team to favorite' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    team = Team.create(name: 'Fly Esports', players: %w[Nikita Azamat Igor Yan Ruslan], coach: 'Valera', shortname: 'LOSE', region: 'LCL')
    visit new_session_path


    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click
    sleep(1)

    visit teams_index_path
    sleep(1)
    click_link('🤍')

    expect(page).to have_text 'Команда Fly Esports была добавлена в избранное'
  end
  scenario 'deleting team from favorite' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    team = Team.create(name: 'Fly Esports', players: %w[Nikita Azamat Igor Yan Ruslan], coach: 'Valera', shortname: 'LOSE', region: 'LCL')
    Favorite.create(user: user, team: team)
    visit new_session_path


    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click
    sleep(1)

    visit teams_index_path
    sleep(1)
    click_link('❤️')

    expect(page).to have_text 'Команда Fly Esports была удалена из избранного'
  end
end

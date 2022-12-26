# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'favorite page', type: :system do
  scenario 'adding team to favorite' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    team1 = Team.create(name: 'Fly Esports', players: %w[Nikita Azamat Igor Yan Ruslan], coach: 'Valera', shortname: 'SILA', region: 'LCL')
    team2 = Team.create(name: 'Unicorns of Love', players: %w[loser1 loser2 loser3 loser4 loser5], coach: 'main_loser', shortname: 'WEAK', region: 'LCL')
    Favorite.create(team: team1, user: user)
    Match.create(team1: "#{team1.shortname}  ", team2: team2.shortname, region: 'LCL', result: team1.shortname, time: Time.now)
    visit new_session_path


    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    find('#my_button').click
    sleep(1)

    visit root_path
    find('#fav').click
    find('#go_button').click
    sleep(1)
    expect(page).to have_text "SILA\n1 - 0\nWEAK"
  end
end

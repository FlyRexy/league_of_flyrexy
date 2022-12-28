# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user trying to get he should not be', type: :feature do
  # Попытка попасть на страницу редактирования профиля, будучи неавторизованным
  scenario 'edit profile' do
    user = User.create(login: 'TestSigningIn', email: 'user@mail.ru', password: 'testPassword21',
                       password_confirmation: 'testPassword21', email_confirmed: 'true')
    visit edit_user_path(user)
    sleep(1)


    expect(page).to have_text 'Вы не авторизованы'
  end
end

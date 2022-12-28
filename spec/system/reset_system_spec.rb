# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'reset password', type: :system do

  # Сброс пароля и получение уведомления
  scenario 'getting notice of resetting password' do
    visit new_session_path

    find('#forgot_pass_link').click

    some_email = 'reset.test@mail.ru'

    fill_in 'email', with: some_email

    find('#reset_button').click

    expect(page).to have_text('Проверьте свою почту для сброса пароля')
  end
end

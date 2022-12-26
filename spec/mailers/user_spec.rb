# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  context 'when we send registration letter' do
    let!(:user_data) do
      { login: 'TestMailer', password: 'TestMailer12', password_confirmation: 'TestMailer12', email: 'user@mail.ru'}
    end
    let!(:user) { User.create(user_data) }

    let(:mail) { UserMailer.registration_confirmation(user) }

    it 'sents correct title' do
      expect(mail.subject).to eq('Подтверждение регистрации')
    end

    it 'sents letter to correct email' do
      expect(mail.to).to eq(['user@mail.ru'])
    end

    it 'sents letter from correct email' do
      expect(mail.from[0]).to eq 'flyrexy.app@gmail.com'
    end

    it 'renders the body' do
      expect(mail.body.encoded).not_to be_empty
    end
  end
end

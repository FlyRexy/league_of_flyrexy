# frozen_string_literal: true

require 'securerandom'
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let!(:user_data) do
      { login: 'TestLogin', password: '123TestGood', password_confirmation: '123TestGood', email: 'user@gmail.com'}
    end
    let!(:user_email_repeat) do
      { login: 'DifferentTestLogin', password: '123TestGood', password_confirmation: '123TestGood', email: 'user@gmail.com'}
    end
    let!(:user_login_repeat) do
      { login: 'TestLogin', password: '123TestGood', password_confirmation: '123TestGood', email: 'test@mail.ru'}
    end
    let!(:bad_passwords) do
      {login: 'IDC', password: 'GoodPassword12', password_confirmation: 'DifferentPassword12', email: 'test@gmail.com'}
    end
    let!(:user_main) { User.create(user_data) }
    let!(:second_user) {User.create(email: 'goodemail@mail.ru', login: 'Test2Login', password: 'ValidPass2', password_confirmation: 'ValidPass2')}
    let!(:user_mail_repeat) { User.new(user_email_repeat) }
    let!(:user_logn_repeat) { User.new(user_login_repeat) }
    let!(:user_passwords_not_matching) {User.new(bad_passwords)}

    # Попытка создать пользователя с почтой, которая уже существует
    it "don't allow to repeat e-mail" do
      expect(user_mail_repeat.valid?).to eq(false)
    end

    # Попытка создать пользователя с логином, который уже существует
    it "don't allow to repeat login" do
      expect(user_logn_repeat.valid?).to eq(false)
    end

    # Попытка создать пользователя с не совпадающими паролями
    context 'when passwords are not matching' do
      it 'should be invalid' do
        expect(user_passwords_not_matching.valid?).to eq(false)
      end
    end

    it { should validate_presence_of(:email).with_message('не может быть пустым') }
    it { should validate_presence_of(:login).with_message('не может быть пустым') }
    it { should validate_presence_of(:password).with_message('не может быть пустым') }
    it { should validate_uniqueness_of(:login).with_message('уже существует') }
    it { should validate_uniqueness_of(:email).with_message('уже существует') }

    # Проверка валидации почты
    context 'when email is valid' do
      it {
        should allow_value("#{Faker::Lorem.word}@#{[*'a'..'z'].shuffle[2..5].join}.#{[*'a'..'z'].shuffle[2..3].join}").for(:email)
      }
    end

    # Попытка обновить данные пользователя с неправильным старым паролем
    context 'when we change password with invalid old password' do
      it 'should return an error' do
        user = User.find_by_login('TestLogin')
        expect(user.update(old_password: 'Invalid', password: 'GoodPassword1', password_confirmation: 'GoodPassword1', old_password_needs: true)).to eq false
      end
    end

    # Попытка обновить данные пользователя
    context 'when we update profile data' do
      it 'should change login w/o any errors' do
        user = User.find_by_login('TestLogin')
        expect(user.update(login: 'TestLogin2')).to eq true
      end
      it 'should change email w/o any errors' do
        user = User.find_by_login('TestLogin')
        expect(user.update(email: 'newemail@mail.ru')).to eq true
      end
      it 'should return an error when email is taken' do
        user = User.find_by_login('TestLogin')
        expect(user.update(email: 'goodemail@mail.ru')).to eq false
      end
      it 'should return an error when login is taken' do
        user = User.find_by_login('TestLogin')
        expect(user.update(login: 'Test2Login')).to eq false
      end
      it 'should change password with errors' do
        user = User.find_by_login('TestLogin')
        expect(user.update(password: 'Newpassword1', password_confirmation: 'DifferentPassword1')).to eq false
      end
    end

    # Проверка валидации логина
    context 'when login is valid' do
      it { should allow_value(Faker::Lorem.word).for(:login) }
    end
  end
end
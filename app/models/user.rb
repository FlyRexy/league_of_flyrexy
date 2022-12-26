class User < ApplicationRecord
  attr_accessor :old_password, :old_password_needs

  has_secure_password validations: false
  validates :email , presence: { message: 'не может быть пустым' }, uniqueness: {message: "уже существует"}
  validates :login , presence: { message: 'не может быть пустым' }, uniqueness: {message: "уже существует"}
  validates :password, confirmation: true, allow_blank: true, length: { minimum: 8, maximum: 70 }
  validate :correct_old_password, on: :update, if: -> { password.present? and old_password_needs }
  validate :password_presence
  before_create :confirmation_token
  before_update :clear_reset_token, if: :password_digest_changed?

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  def set_reset_password_token
    update password_reset_token: digest(SecureRandom.urlsafe_base64),
           password_reset_token_sent_at: Time.current
  end

  def clear_reset_token
    self.password_reset_token = nil
    self.password_reset_token_sent_at = nil
  end

  def password_reset_period_valid?
    password_reset_token_sent_at.present? and Time.current - password_reset_token_sent_at < 10.minutes
  end

  private

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'был введен неправильно!🐨'
  end

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def password_presence
    errors.add(:password, :blank) unless password_digest.present?
  end

  def digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end
end

class User < ApplicationRecord
  USERS_PARAMS = %i(name
                    email
                    password
                    password_confirmation
                    birth
                    phone_number).freeze
  VALID_EMAIL_REGEX = Settings.validation.user.format.email

  validates :name, presence: true,
    length: {maximum: Settings.validation.user.name_size}
  validates :email, presence: true,
    length: {maximum: Settings.validation.user.email_size},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :password, presence: true,
    length: {minimum: Settings.validation.user.password_size}

  has_many :borrowings, dependent: :destroy

  enum role: {user: 0, admin: 1}

  acts_as_paranoid

  before_save :downcase_email

  has_secure_password

  def downcase_email
    email.downcase!
  end
end

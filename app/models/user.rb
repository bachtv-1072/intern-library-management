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
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: true}
  validates :password, presence: true,
    length: {minimum: Settings.validation.user.password_size}

  has_many :borrowings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy

  enum role: {user: 0, admin: 1}

  scope :search_by_user_name, (lambda do |name|
    where "name LIKE ?", "%#{name}%" if name.present?
  end)

  acts_as_paranoid

  before_save :downcase_email

  has_secure_password

  def downcase_email
    email.downcase!
  end

  class << self
    def ransackable_scopes auth_object = nil
      return unless auth_object == :admin

      [:search_by_user_name]
    end
  end
end

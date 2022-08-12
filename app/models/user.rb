class User < ApplicationRecord
  before_save :downcase_email

  validates :email, presence: true,
                    length: {minium: Settings.min_length,
                             maximum: Settings.max_length},
                    format: {with: Settings.email_regex},
                    uniqueness: {case_sensitive: false}

  validates :name, presence: true,
                   length: {minium: Settings.min_length,
                            maximum: Settings.max_length}

  has_secure_password
  validates :password, presence: true,
                       length: {minimum: Settings.password_min_length},
                       allow_nil: true
  private

  def downcase_email
    email.downcase!
  end
end

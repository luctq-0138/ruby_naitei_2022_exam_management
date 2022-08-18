class User < ApplicationRecord
  has_many :exams, dependent: :destroy

  USER_ATTRS = %i(name email password password_confirmation).freeze
  enum role_id: {user: 0, admin: 1}
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

  def activate
    update activated: !activated, activated_at: Time.zone.now
  end

  private

  def downcase_email
    email.downcase!
  end
end

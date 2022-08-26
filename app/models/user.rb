class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  
  before_save :downcase_email

  validates :name, presence: true,
                   length: {maximum: Settings.valid.name_max_len}

  validates :email, presence: true,
                    format: {with: Settings.regex.email_regex},
                    uniqueness: {case_sensitive: false},
                    length: {maximum: Settings.valid.email_max_len}

  validates :password, presence: true,
                       length: {minimum: Settings.valid.password_min_len,
                                maximum: Settings.valid.password_max_len}

  validates :address, presence: true,
                      length: {maximum: Settings.valid.address_max_len}

  validates :phone_number, presence: true,
                           format: {with: Settings.regex.phone_number_regex},
                           length:
                            {minimum: Settings.valid.phone_number_min_len,
                             maximum: Settings.valid.phone_number_max_len}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end

class Order < ApplicationRecord
  belongs_to :user
  enum status: {inactive: 0, actived: 1, paid: 2}
  scope :newest, ->{order(created_at: :desc)}

  validates :user_name, presence: true,
                   length: {maximum: Settings.valid.name_max_len}

  validates :address, presence: true,
                      length: {maximum: Settings.valid.address_max_len}

  validates :phone_number, presence: true,
                           format: {with: Settings.regex.phone_number_regex},
                           length:
                            {minimum: Settings.valid.phone_number_min_len,
                             maximum: Settings.valid.phone_number_max_len}

  validates :note, presence: false,
                      length: {maximum: Settings.valid.note_max_len}

  validates :payment_type, presence: true
end

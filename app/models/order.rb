class Order < ApplicationRecord
  belongs_to :user
  enum status: {inactive: 0, actived: 1, paid: 2}
  scope :newest, ->{order(created_at: :desc)}
end

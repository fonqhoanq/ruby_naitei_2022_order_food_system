class Order < ApplicationRecord
  belongs_to :user
  enum status: {Inactive: 0, In_process: 1, Actived: 2}
  scope :newest, ->{order(created_at: :desc)}
end

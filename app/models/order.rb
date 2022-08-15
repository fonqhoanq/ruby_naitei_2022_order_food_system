class Order < ApplicationRecord
  belongs_to :user
  enum status: {inactive: 0, in_process: 1, actived: 2}
end

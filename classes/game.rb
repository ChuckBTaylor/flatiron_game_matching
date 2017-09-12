class Game < ActiveRecord::Base
  has_many :gaming_queues
  has_many :users, through: :gaming_queues
end

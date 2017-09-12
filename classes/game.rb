class Game < ActiveRecord::Base
  has_many :gaming_queues
  has_many :users, through: :gaming_queues
  # ALL = []
  # attr_reader :players_needed
  #
  # def initialize(name = nil, min_player_count = nil, max_player_count = nil, owner = "Flatiron", quick_description = nil)
  #   @name = name
  #   @players_needed = (min_player_count..max_player_count).to_a
  #   @owner = owner
  #   @quick_description = quick_description ? quick_description : get_description
  #   ALL << self
  # end
  #
  #
  # def get_description
  #   puts "Tell us about the game"
  #   gets.chomp
  # end
  #
  # # def persist
  # #
  # # end
  #
  # def self.all
  #   ALL
  # end




end

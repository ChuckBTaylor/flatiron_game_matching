class GamingQueue < ActiveRecord::Base[5.1]

  ALL = []
  attr_reader :user, :game

  def initialize(user, game)
    @user = user
    @game = game
    ALL << self
  end

  def self.all
    ALL
  end


end

class User < ActiveRecord::Base
  has_many :gamings
  has_many :games, through: :gaming_queues

  # def join_queue(game)
  #   GamingQueue.new(self, game)
  # end
  #
  # def leave_queue(game)
  #
  # end
  #
  # def view_all_games
  #   Game.all.each do |game|
  #     puts game.name
  #   end
  # end
  #
  # def view_user_games
  #   GamingQueue.all.select {|gameQ| gameQ.user == self}.map {|gameQ| gameQ.game}
  # end
  #
  # # def view_all_queued_games_with_users
  # #   GamingQueue.all.map do |gameQ|
  # #     gameQ.game
  # #   end
  # # end
  #
  # def view_all_queued_games
  #   GamingQueue.all.map do |gameQ|
  #     gameQ.game
  #   end.uniq
  # end
  #
  # def add_game
  #   puts "What is the name of the game?"
  #   name = gets.chomp
  #   puts "What is the minimum number of players?"
  #   min = gets.chomp.to_i
  #   puts "What is the maximum number of players?"
  #   max = gets.chomp.to_i
  #   new_game = Game.new(name, min, max, self)
  #   # new_game.persist
  # end
  #
  # def remove_game(game)
  #   if game.owner == self
  #     #game.remove_from_library
  #   else
  #     puts "You don't have persmission to remove that game!"
  #   end
  # end

end

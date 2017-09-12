class User < ActiveRecord::Base
  has_many :gamings
  has_many :games, through: :gaming_queues

  #

  def join_queue(game)
    new_gaming_q = GamingQueue.new(user_id:self.id, game_id:game)
    new_gaming_q.save
  end

  #

  def leave_queue
    puts "Which gaming queue would you like to leave?"
    self.view_user_games
    choice = gets.chomp
    game_id = Game.find_by(name: choice).id
    gameQ_id = GamingQueue.find_by(game_id:game_id, user_id:self.id).id
    GamingQueue.destroy(gameQ_id)
  end

#

  def view_user_games
    puts ""
    GamingQueue.where(user_id: self.id).map do |gameQ|
      gameQ.game_id
    end.map do |game_id|
      Game.where(id: game_id)
    end.flatten.each do |game|
      puts game.name
    end
    puts ""
  end

  #

  def add_game
    puts "What is the name of the game?"
    name = gets.chomp
    puts "What is the minimum number of players?"
    min = gets.chomp.to_i
    puts "What is the maximum number of players?"
    max = gets.chomp.to_i
    puts "Give us a brief description"
    quick_description = gets.chomp
    new_game = Game.new(name: name, min: min, max: max, user_id: self.id)
    new_game.save
  end

  #

  def remove_game
    puts "Which game would you like to remove?"
    Game.where(user_id:self.id).each {|game| puts game.name}
    choice = gets.chomp
    game = Game.find_by(name:choice)
    if game.user_id == self.id
      Game.destroy(game.id)
    else
      puts "You don't have permission to remove that game."
    end
  end
end

def welcome
  puts "Welcome the magical game matching app!"
end

def sign_in
  puts "Please enter username or type 'new user' to create a new user" #and password"
  user_name = gets.chomp.downcase
if user_name == 'quit' || user_name == 'e'
    return nil
  end
  user_name = user_name.downcase == "new user" ? create_new_user : user_name
  has_user = User.where("lower(user_name) = ?", user_name.downcase).first
  unless has_user
    puts "\nUser name not found"
    puts "\nType 'quit' to leave"
    has_user = sign_in
  end
  has_user
end


def create_new_user
  yn = 'a'
  until yn.downcase == 'y' do
    puts "Please enter your name"
    name = gets.chomp
    puts "Please enter your user name"
    user_name = gets.chomp
    puts "\n Is this correct? (Y/N)"
    puts "Name: #{name}   User name:#{user_name}"
    yn = gets.chomp
  end

  new_user = User.new({name: name, user_name: user_name})
  new_user.save
  user_name
end

def prompt_user(user)
  puts "What would you like to do?"
  puts "  [View] all games/[Join] a game queue"
  puts "  [Leave] a game queue"
  puts "  [Abandon] all game queues"
  puts "  [Add] a game to the list"
  puts "  [Remove] my game from the list"
  puts "  [My] gaming queue"
  puts "  [Logout]"

  choice = gets.chomp

  case choice.downcase
  when "join","jon","view","vew","veiw","jin"
    choose_game(user)
  when "leave","leav","leve","lave","laeve"
    user.leave_queue
  when "abandon","abandn","abando"
    user.leave_all_queues
  when "add","ad","dad"
    user.add_game
  when "remove"
    user.remove_game
  when "my","ym"
    user.view_user_games
  when "logout","lgout","quit","qut","qiut","qit", "exit"
    $logout = true
  else
  end
end

def choose_game(user)
  puts "What game would you like to play?"
  Game.all.each do |game|
    puts "#{game.id}: #{game.name}"
  end
  puts "Which game would you like to join?"
  puts "  or '0' to return"
  game = gets.chomp.to_i
  unless game == 0
    user.join_queue(game)
  end
end

def goodbye
  puts "Thanks for using Flatch!"
end

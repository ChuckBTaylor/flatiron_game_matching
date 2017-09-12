require_relative "../config/environment.rb"


ashe = User.find_by(user_name:"AsheBashe")

will = User.find_by(user_name: "ChuckBTaylor")
will.save

anna = User.find_by(user_name: "Annnnnna")
anna.save

# settlers = Game.new(name:"Settlers of Catan",min:3,max:4,quick_description:"It's a lot of fun")
# dominion = Game.new(name:"Dominion",min:2,max:4,quick_description:"Deck-building game")
# will.join_queue(settlers)
# ashe.join_queue(settlers)
# ashe.join_queue(dominion)


binding.pry
"Test"

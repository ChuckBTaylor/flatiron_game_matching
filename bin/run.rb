require_relative "../config/environment.rb"


# ashe = User.find_by(user_name:"AsheBashe")
# flatiron = User.find_or_create_by(name:"Flatiron School", id:1)

welcome
#----
user = sign_in #user is the instance of User variable
$logout = false
if user
  while $logout == false
    prompt_user(user)
    if $logout == true
      user = nil
    end
  end
end
goodbye
#----
binding.pry
"Test"

require_relative "../config/environment.rb"
require_relative "../config/seed.rb"

welcome
# ----
user = sign_in # instance of user variable.
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
# ----

binding.pry

require_relative '../config/environment'



display
greeting
user_response = gets.chomp
ask_for_username(user_response)
# if user_response == 'Y'
#     puts "Please enter username"
#     user_input = gets.chomp
#     user = User.find_by username: user_input
#     puts "Welcome #{user.name}!"
# elsif user_response == 'N'
#     puts "create account"
# end

main_menu


require_relative '../config/environment'



display
greeting
user_response = gets.chomp

if user_response == 'Y'
    puts "find account"
elsif user_response == 'N'
    puts "create account"
end

menu

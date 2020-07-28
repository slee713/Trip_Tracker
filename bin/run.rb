require_relative '../config/environment'



display
greeting


while true
    user_response = gets.chomp
    if user_response == 'Y'
        puts "Please enter username"
        user_input = gets.chomp
        user = User.find_by username: user_input
        break
    elsif user_response == 'N'
        puts "Let's make an account!"
        puts "Please enter your username"
        while true
            user_username = gets.chomp
            if User.all.map {|user| user.username}.include?(user_username)
                puts "That username is already taken. Please enter new username."
            else 
                puts "What is your name?"
                user_name = gets.chomp
                user = User.create(name: user_name, username: user_username)
                break
            end
        end
        break
    else 
        puts "Invalid response. Do you have an account? (Y/N)"
    end
end


main_menu(user)
main_menu_response

user_input = gets.chomp
if user_input.to_i == 1
    
    #resume 7/28/20
elsif user_input.to_i == 2
    trips = Trip.all.find_all {|trip| trip.user_id = user.id}
    trips
    binding.pry
elsif user_input.to_i == 3
    
elsif user_input.to_i == 4
    delete_account
end





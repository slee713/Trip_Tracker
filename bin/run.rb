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
main_menu_response(user)







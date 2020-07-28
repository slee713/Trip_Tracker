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




puts "
███╗   ███╗ █████╗ ██╗███╗   ██╗    ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
████╗ ████║██╔══██╗██║████╗  ██║    ████╗ ████║██╔════╝████╗  ██║██║   ██║
██╔████╔██║███████║██║██╔██╗ ██║    ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
██║╚██╔╝██║██╔══██║██║██║╚██╗██║    ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
██║ ╚═╝ ██║██║  ██║██║██║ ╚████║    ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝    ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ 
                                                                          
"
puts "WELCOME #{user.name}"
puts "1. Enter a new Trip"
puts "2. Find all of you trips and update any trip" # list of trips we can 
#have another menu with 1. View Stops for a trip 
#2. Update trip. 
#3. Delete Trip 
puts "3. Find all of the states/countries you have visited"
puts "4. Delete Account"
puts "Please enter a number (1-4)"

user_input = gets.chomp
if user_input.to_i == 1
    puts "Enter a new Trip"
    puts "What is the name of your trip?"
    trip_name = gets.chomp
    puts "What was your method of transportation?"
    transportation = gets.chomp
    puts "What was your start date?"
    start = gets.chomp
    puts "What was your end date?"
    user_end_date = gets.chomp
    Trip.create(
        user_id: user.id, 
        name: trip_name, 
        transportation: transportation,
        start_date: Date.parse(start),
        end_date: Date.parse(user_end_date)
        )
elsif user_input.to_i == 2
    trips = Trip.all.find_all {|trip| trip.user_id = user.id}
    trips
    binding.pry
elsif user_input.to_i == 3
    
elsif user_input.to_i == 4
    delete_account
end


main_menu_response


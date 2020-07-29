
def display
    puts "
    ████████╗██████╗  █████╗ ██╗   ██╗███████╗██╗         ████████╗██████╗  █████╗  ██████╗██╗  ██╗███████╗██████╗ 
    ╚══██╔══╝██╔══██╗██╔══██╗██║   ██║██╔════╝██║         ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
       ██║   ██████╔╝███████║██║   ██║█████╗  ██║            ██║   ██████╔╝███████║██║     █████╔╝ █████╗  ██████╔╝
       ██║   ██╔══██╗██╔══██║╚██╗ ██╔╝██╔══╝  ██║            ██║   ██╔══██╗██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
       ██║   ██║  ██║██║  ██║ ╚████╔╝ ███████╗███████╗       ██║   ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║
       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚══════╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
                                                                                                                   
    "
    # puts << 'EOF'
    #                                                      |
    #                                                --====|====--
    #                                                      |  

    #                                                  .-"""""-. 
    #                                                .'_________'. 
    #                                               /_/_|__|__|_\_\
    #                                              ;'-._       _.-';
    #                         ,--------------------|    `-. .-'    |--------------------,
    #                          ``""--..__    ___   ;       '       ;   ___    __..--""``
    #                                     `-// \\.._\             /_..// \\-"`
    #                                       \\_//    '._       _.'    \\_//
    #                                        `"`        ``---``        `"`
    # EOF>>
end

def greeting
    puts "Welcome to Travel Tracker! Do you have an account? (Y/N)"
    while true
        user_response = gets.chomp.downcase
        if user_response == 'Y'.downcase
            puts "Please enter username"
            user_input = gets.chomp.downcase
            $user = User.find_by username: user_input
            break
        elsif user_response == 'N'.downcase
            create_account
            break
        else 
            puts "Invalid response. Do you have an account? (Y/N)"
        end
    end
end

def create_account
    puts "Let's make an account!"
        puts "Please enter your username"
        while true
            user_username = gets.chomp.downcase
            if User.exists?(:username => user_username)
                puts "That username is already taken. Please enter new username."
            else 
                puts "What is your name?"
                user_name = gets.chomp
                $user = User.create(name: user_name, username: user_username)
                break
            end
        end
end



def main_menu(user)#$user
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
    puts "5. Exit"
    puts "Please select from the options above using numbers (1-5) as your input:"

    user_input = gets.chomp
    
    case user_input
    when "5"
        exit
    when "1"
        enter_new_trip(user)
    when "2"
        user.list_trips
    when "3"
        find_all_states_and_countries(user)
    when "4"
        delete_account(user)
    else 
        puts "Invalid entry."
        main_menu(user)
    end
end

def enter_new_trip(user)
    puts "Enter a new Trip"
    puts "What is the name of your trip?"
        trip_name = gets.chomp
    puts "What was your method of transportation?"
        transportation = gets.chomp
    puts "What was your start date? (YYYY/MM/DD)"
        start = gets.chomp
    puts "What was your end date? (YYYY/MM/DD)"
        user_end_date = gets.chomp
    trip = Trip.create(
        user_id: user.id, 
        name: trip_name, 
        transportation: transportation,
        start_date: Date.parse(start),
        end_date: Date.parse(user_end_date)
        )
    create_locations(trip)
end

def create_locations(new_trip)
        puts "Which city did you visit on this trip?"
            location_name = gets.chomp
        puts "Which state or country was it in?"
            location_statecountry = gets.chomp
            all_location_name = Location.all.map {|location| location.city_name}
        if !all_location_name.include?(capitalize(location_name))
            location = Location.create(
                city_name: capitalize(location_name),
                state_or_country: capitalize(location_statecountry)
                )
            create_spots(new_trip, location)
            another_spot?(new_trip)
        elsif all_location_name.include?(capitalize(location_name))
            location = (Location.find_by city_name: capitalize(location_name))
            create_spots(new_trip, location)
            another_spot?(new_trip)
        end
end

def capitalize(string)
    array = string.split(" ")
    array.map {|word| word.capitalize}.join(" ")
end

def create_spots(trip, location) # doesnt work
    puts "How would you rate this stop? (1-10)?"
    user_rating = gets.chomp
    puts "Please write a description for this stop."
    user_description = gets.chomp
    Stop.create(
        trip_id: trip.id,
        location_id: location.id,
        rating: user_rating,
        description: user_description
    )
end

def another_spot?(new_trip)
    puts "Did you visit another spot on this trip? (Y/N)"
    response = gets.chomp.downcase
    if response == "Y".downcase
        create_locations(new_trip)
    elsif response == 'N'.downcase
        main_menu($user)
    else
        puts "Invalid Response. Please enter 'y' or 'n'."
        another_spot?(new_trip)
    end  
end


def find_all_states_and_countries(user)
    locations = user.find_all_locations
    list_of_locations(locations.uniq)
    main_menu(user)
end

def delete_account(user)
    puts "Do you want to delete this account. (Y/N)"
        user_input = gets.chomp.downcase
        if user_input == 'y'
            User.all.delete(user)
            puts "Account Deleted"
            puts "Thank you for using Trip Tracker!"
            exit
        elsif user_input == 'n'
            main_menu($user)
        else
            puts "Invalid input. Please type 'y' or 'n'. "
            delete_account(user)
        end
end

def list_of_locations(location)
    puts "Here are all of the locations you have visited!"
    location.each_with_index {|location, index| 
    puts "#{index+1}. #{location.city_name}, #{location.state_or_country}"
    }
    puts "Would you like to edit or delete a trip?"
end








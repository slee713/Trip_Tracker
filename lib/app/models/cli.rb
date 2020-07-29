
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
    puts "WELCOME #{user.name.upcase}"
    puts "1. Enter a new Trip" #working
    puts "2. Find all of you trips and update any trip" # list of trips we can 
    #have another menu with 1. View Stops for a trip 
    #2. Update trip. 
    #3. Delete Trip 
    puts "3. Find all of the states/countries you have visited" #working
    puts "4. Delete Account" #working
    puts "5. Exit" #working
    puts "Please select from the options above using numbers (1-5) as your input:"

    user_input = gets.chomp
    
    case user_input
    when "5"
        exit
    when "1"
        enter_new_trip(user)
    when "2"
        user.list_trips
        if user.find_trips == []
            puts "You have no trips! Please enter a new trip!"
            enter_new_trip(user)
        end
        update_or_delete_trip(user.find_trips)
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
        start_date = Date.parse(start)
    puts "How many days did you spend on this trip?"
        duration = gets.chomp.to_i
        user_end_date = start_date + duration
    trip = Trip.create(
        user_id: user.id, 
        name: trip_name, 
        transportation: transportation,
        start_date: start_date,
        end_date: user_end_date
        )
    create_locations(trip)
end
#trips is an array of a user's trips
def update_or_delete_trip(trips)
    while true
        puts "Please select the following options: (1-3) "
        puts "1. View all stops for a trip"
        puts "2. Update a Trip"
        puts "3. Delete a Trip and all of its Stops"
        puts "4. Go back to the main menu"
        user_input = gets.chomp
        if user_input == '1'
            trip = choose_trip(trips)
            trip.stop_information
        elsif user_input == '2'
            trip = choose_trip(trips)
            update_trip(trip)
        elsif user_input == '3'
            delete_trip_stops(trips)
        elsif user_input == '4'
            main_menu($user)
        else
            puts "Invalid Response. Please enter a number (1-3)"
            update_or_delete_trip(trips)
        end
    end
end

def delete_trip_stops(trips)
    trip = choose_trip(trips)
    Stop.where(trip_id: trip.id).delete_all 
    Trip.delete(trip.id)
    puts "Trip Deleted!"
    main_menu($user)
end

def choose_trip(trips_array)
    puts "Please choose a trip: (1 - #{trips_array.length})"
    user_input = gets.chomp
    trips_array[user_input.to_i-1]
end

def update_trip(trip)
    while true
        puts "What would you like to edit? Please enter a number (1-5):"
        puts "1. Trip Name"
        puts "2. Trip Transportation Method"
        puts "3. Trip Date Information"
        puts "4. Stop information for this Trip"
        puts "5. Go Back to Main Menu"
        user_input = gets.chomp
        if user_input == '1'
            puts "Please enter a new name"
            new_name = gets.chomp
            trip.update_column(:name, new_name)
        elsif user_input == '2'
            puts "Please enter a new trasnportation method"
            new_method = gets.chomp
            trip.update_column(:transportation, new_method)
        elsif user_input == '3' 
            puts "Please enter start date (YYYY/MM/DD)"
            new_date = gets.chomp
            date = Date.parse(new_date)
            puts "How many days did you spend on this trip?"
            duration = gets.chomp.to_i
            trip.update_column(:start_date, date)
            trip.update_column(:end_date, date+duration)
        elsif user_input == '4'
            stop_information(trip)
        elsif user_input == '5'
            main_menu($user)
        else
            puts "Invalid Response. Please enter a number from 1-5."
        end
    end
end


def stop_information(trip)
    stops = trip.stops
    puts "Which stop would you like to edit?"
    trip.list_stops_by_location_name
    puts "#{stops.length+1}. Add a stop"
    puts "Please choose a option: (1 - #{stops.length+1})"
    user_input = gets.chomp
    stop = stops[user_input.to_i-1]
    if user_input.to_i <= stops.length && user_input.to_i>0
        while true
            puts "What would you like to change?"
            puts "1. Change Rating"
            puts "2. Description"
            puts "3. Go back to the main menu"
            user_choice = gets.chomp 
            if user_choice == '1'
                puts "Please enter a new rating (1-10) for this stop:"
                change_rating = gets.chomp.to_i
                stop.update_column(:rating, change_rating)
            elsif user_choice == '2'
                puts "Please enter a new description for this stop:"
                change_desc = gets.chomp
                stop.update_column(:description, change_desc)
            elsif user_choice == '3'
                main_menu($user)
            end
        end
    elsif user_input.to_i == stops.length+1
        create_locations(trip)
    end
end

def find_all_states_and_countries(user)
    locations = user.find_all_locations
    list_of_locations(locations.uniq)
    go_back_to_menu?(user)
end

def delete_account(user)
    puts "Do you want to delete this account. (Y/N)"
    user_input = gets.chomp.downcase
    if user_input == 'y'
        trips = Trip.where(user_id: user.id)
        trips.each do |trip|
             Stop.where(trip_id: trip.id).delete_all
        end
        Trip.where(user_id: user.id).delete_all
        User.delete(user.id)
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

#helper methods
def capitalize(string)
    array = string.split(" ")
    array.map {|word| word.capitalize}.join(" ")
end

#helper methods for enter_new_trip
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

def create_spots(trip, location) 
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
        go_back_to_menu?($user)
    else
        puts "Invalid Response. Please enter 'y' or 'n'."
        another_spot?(new_trip)
    end  
end

#helper method for find all states or countries
def list_of_locations(location)
    puts "Here are all of the locations you have visited!"
    location.each_with_index {|location, index| 
    puts "#{index+1}. #{location.city_name}, #{location.state_or_country}"
    }
end

def go_back_to_menu?(user)
    puts "Do you want to go back to the main menu? (Y/N)?"
    while true
        response = gets.chomp.downcase
        if response == 'Y'.downcase
            main_menu(user)
        elsif response == 'N'.downcase
            exit
        end
    end
end









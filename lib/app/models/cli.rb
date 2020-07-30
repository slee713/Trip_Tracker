require 'rainbow'
def display
    puts  Rainbow("
          ████████╗██████╗ ██╗██████╗     ████████╗██████╗  █████╗  ██████╗██╗  ██╗███████╗██████╗ 
          ╚══██╔══╝██╔══██╗██║██╔══██╗    ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
             ██║   ██████╔╝██║██████╔╝       ██║   ██████╔╝███████║██║     █████╔╝ █████╗  ██████╔╝
             ██║   ██╔══██╗██║██╔═══╝        ██║   ██╔══██╗██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
             ██║   ██║  ██║██║██║            ██║   ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║
             ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝            ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝                                                                                                                                                             
    ").red.bright
    puts Rainbow("
       _______  _______          _______  _______  _____          _     _  _____    __   ______  ______      
      |    ___||   _   |        |  _____||   ___||   ___|        | |   | ||   _ |  |  | |_    _||   ___|      
      |   | __ |  | |  |        | |_____ |  |___ |  |___         | | _ | ||  |_||_ |  |   |  |  |  |___       
      |   ||_ ||  | |  | ___    |_____  ||   ___||   ___| ___    | || || ||   __  ||  |   |  |  |   ___| ___  
      |   |_| ||  |_|  ||   |    _____| ||  |___ |  |___ |   |   |   _   ||  |  | ||  |   |  |  |  |___ |   | 
      |_______||_______||___|   |_______||______||______||___|   |__| |__||__|  |_||__|   |__|  |______||___| 
 ")
end

def greeting
    puts "                      Welcome to Trip Tracker! The app that keeps track of all your trips!"
    puts "                                             Do you have an account? (Y/N)"
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



def main_menu(user)
    puts Rainbow("
                        ███╗   ███╗ █████╗ ██╗███╗   ██╗    ███╗   ███╗███████╗███╗   ██╗██╗   ██╗
                        ████╗ ████║██╔══██╗██║████╗  ██║    ████╗ ████║██╔════╝████╗  ██║██║   ██║
                        ██╔████╔██║███████║██║██╔██╗ ██║    ██╔████╔██║█████╗  ██╔██╗ ██║██║   ██║
                        ██║╚██╔╝██║██╔══██║██║██║╚██╗██║    ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
                        ██║ ╚═╝ ██║██║  ██║██║██║ ╚████║    ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
                        ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝    ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ 
                                                                              
    ").blue
    puts Rainbow("                                                 WELCOME #{user.name.upcase}").black
    puts " \n                                 1. Enter a new Trip" 
    puts "                                 2. Find all of you trips and update any trip" 
    puts "                                 3. Find all of the states/countries you have visited" 
    puts "                                 4. Delete Account" 
    puts "                                 5. Exit" 
    puts "\n                        Please select from the options above using numbers (1-5) as your input:"

    user_input = gets.chomp
    
    case user_input
    when "5"
        system "clear"
        puts "                                       Thank you for using Trip Tracker!!"
        puts "                                                      Good Bye!!"
        exit
    when "1"
        system "clear"
        enter_new_trip(user)
    when "2"
        system "clear"
        user.list_trips
        if user.find_trips == []
            puts "You have no trips! Please enter a new trip!"
            enter_new_trip(user)
        end
        update_or_delete_trip(user.find_trips)
    when "3"
        system "clear"
        find_all_states_and_countries(user)
        system "clear"
    when "4"
        system "clear"
        delete_account(user)
    else 
        system "clear"
        puts "Invalid entry."
        main_menu(user)
    end
end

#USER STORY 1) ENTER A NEW TRIP
#allows user to enter attributes of a trip through prompts and addes stops through helper methods
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

#USER STORY 2, Update/Delete existing trips
def update_or_delete_trip(trips)
    while true
        puts "Please select the following options: (1-5) "
        puts "1. View Trip Information"
        puts "2. View All Stop Information for a Trip"
        puts "3. Update a Trip"
        puts "4. Delete a Trip and All of its Stops"
        puts "5. Go Back to the Main Menu"
        user_input = gets.chomp
        if user_input == '1'
            system "clear"
            puts "Please choose a trip to view its information: (1 - #{trips.length})"
            $user.list_trips
            trip=choose_trip(trips)
            puts "Here is the trip information for #{trip.name}"
            trip.view_information
        elsif user_input == '2'
            system "clear"
            puts "Please choose a trip to view all its Stops: (1 - #{trips.length})"
            $user.list_trips
            trip = choose_trip(trips)
            puts "Here are all the stops for your trip #{trip.name}"
            trip.stop_information
        elsif user_input == '3'
            system "clear"
            puts "Please choose a trip to update: (1 - #{trips.length})"
            $user.list_trips
            trip = choose_trip(trips)
            update_trip(trip)
        elsif user_input == '4'
            system "clear"
            puts "Please choose a trip to delete: (1 - #{trips.length})"
            $user.list_trips
            delete_trip_stops(trips)
        elsif user_input == '5'
            system "clear"
            main_menu($user)
        else
            system "clear"
            puts "Invalid Response. Please enter a number (1-3)"
            update_or_delete_trip(trips)
        end
    end
end


#USER STORY 3, Find all states/countries user went to
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



def delete_trip_stops(trips)
    trip = choose_trip(trips)
    Stop.where(trip_id: trip.id).delete_all 
    Trip.delete(trip.id)
    puts "Trip Deleted!"
    main_menu($user)
end

def choose_trip(trips_array)
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
        existing_location = Location.find_by(city_name: capitalize(location_name), state_or_country: capitalize(location_statecountry))
    if existing_location
        create_stops(new_trip, existing_location)
        another_stop?(new_trip)
    else
        location = Location.create(
            city_name: capitalize(location_name),
            state_or_country: capitalize(location_statecountry)
            )
        create_stops(new_trip, location)
        another_stop?(new_trip)
    end
end

def create_stops(trip, location) 
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


def another_stop?(new_trip)
    puts "Did you visit another stop on this trip? (Y/N)"
    response = gets.chomp.downcase
    if response == "Y".downcase
        create_locations(new_trip)
    elsif response == 'N'.downcase
        go_back_to_menu?($user)
    else
        puts "Invalid Response. Please enter 'y' or 'n'."
        another_stop?(new_trip)
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
            system "clear"
            main_menu(user)
        elsif response == 'N'.downcase
            puts "Thank you for using Trip Tracker!! \n Have a great day!!"
            exit
        else
            puts "Invalid Response. Please enter 'y' or 'n'."
        end
    end
end









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
            puts "\nPlease enter username"
            user_input = gets.chomp.downcase
            if User.exists?(username: user_input)
                $user = User.find_by(username: user_input)
                break
            else
                puts "\nUsername is not valid. Do you have an account? (Y/N)"
            end
        elsif user_response == 'N'.downcase
            create_account
            break
        else 
            puts "\nInvalid response. Do you have an account? (Y/N)"
        end
    end
end

def create_account
    puts "\nLet's make an account!"
        puts "Please enter your username"
        while true
            user_username = gets.chomp.downcase
            if User.exists?(username: user_username)
                puts "\nThat username is already taken. Please enter a new username."
            else 
                puts "\nWhat is your name?"
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
    puts " \n                                 1. Enter a New Trip" 
    puts "                                 2. Find All of Your Trips and Update Any Trip" 
    puts "                                 3. Find All of the States/Countries You Have Visited" 
    puts "                                 4. Delete Account" 
    puts "                                 5. Exit" 
    puts "\n                        Please select from the options above using numbers (1-5) as your input:"

    user_input = gets.chomp
    
    case user_input
    when "5"
        system "clear"
        puts "                                       Thank you for using Trip Tracker!!"
        puts "                                                    Good Bye!!"
        exit
    when "1"
        system "clear"
        enter_new_trip(user)
    when "2"
        system "clear"
        
        if user.find_trips == []
            puts "\nYou have no trips! Would you like to enter a new trip? (Y/N)"
            while true 
                response = gets.chomp
                if response.downcase == 'y'
                    enter_new_trip(user)
                elsif response.downcase == 'n'
                    go_back_to_menu?(user)
                else
                    puts "Invalid Response. Please input 'y' or 'n'. "
                end
            end
        else
            $user.list_trips
            update_or_delete_trip(user.find_trips)
        end
    when "3"
        system "clear"
        find_all_states_and_countries(user)
        system "clear"
    when "4"
        delete_account(user)
    else 
        system "clear"
        puts "\nInvalid entry."
        main_menu(user)
    end
end

#USER STORY 1) ENTER A NEW TRIP
#allows user to enter attributes of a trip through prompts and addes stops through helper methods
def enter_new_trip(user)
    puts "\nEnter a new Trip"
    puts "What is the name of your trip?"
        trip_name = gets.chomp
    puts "\nWhat was your method of transportation?"
        transportation = gets.chomp
    date_found = false
    while not date_found
        puts "What was your start date? (YYYY/MM/DD)"
        date = gets.chomp
        start_date = Date.parse(date)
        puts "\nThe start date is #{start_date}. Is this correct? (Y/N)"
        user_response = gets.chomp
            if user_response.downcase == 'y'
                date_found = true
            end
        end
    puts "\nHow many days did you spend on this trip?"
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
        puts "\nPlease select the following options: (1-5) "
        puts "1. View the Information for A Trip"
        puts "2. View All Stop Information for a Trip"
        puts "3. Update a Trip"
        puts "4. Delete a Trip and All of its Stops"
        puts "5. Go Back to the Main Menu"
        user_input = gets.chomp
        case user_input
        when'1'
            system "clear"
            puts "Please choose a trip to view its information: (1 - #{trips.length})"
            trip=choose_trip(trips)
            puts "\nHere is the trip information for #{trip.name}"
            trip.view_information
        when'2'
            system "clear"
            puts "Please choose a trip to view all its Stops: (1 - #{trips.length})"
            trip = choose_trip(trips)
            puts "\nHere are all the stops for your trip #{trip.name}"
            trip.stop_information
        when'3'
            system "clear"
            puts "Please choose a trip to update: (1 - #{trips.length})"
            trip = choose_trip(trips)
            update_trip(trip)
        when'4'
            system "clear"
            puts "Please choose a trip to delete: (1 - #{trips.length})"
            delete_trip_stops(trips)
            go_back_to_menu?($user)
        when'5'
            system "clear"
            main_menu($user)
        else
            system "clear"
            puts "Invalid Response. Please enter a number (1-5)"
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
end

def choose_trip(trips_array)
    while true
        $user.list_trips
        user_input = gets.chomp.to_i
        if user_input > trips_array.length
            puts "\nUser input #{user_input} is invalid. Please select a valid trip:\n"
        else
            trip = trips_array[user_input.to_i-1]
            break
        end
    end
    trip
end

def update_trip(trip)
    puts "You selected #{trip.name} - #{trip.start_date}."
    while true
        puts "\nWhat would you like to edit? Please enter a number (1-5):"
        puts "1. Trip Name"
        puts "2. Trip Transportation Method"
        puts "3. Trip Date Information"
        puts "4. Stop information for this Trip"
        puts "5. Go Back to Main Menu"
        user_input = gets.chomp
        case user_input
        when '1'
            puts "Please enter a new name for #{trip.name}."
            new_name = gets.chomp
            puts "\nThe name has changed from #{trip.name} to #{new_name}."
            trip.update_column(:name, new_name)
        when '2'
            puts "Please enter a new trasnportation method for #{trip.name}. The current transportation method is #{trip.transportation}"
            new_method = gets.chomp
            puts "\nThe transportation method has changed from #{trip.transportation} to #{new_method}."
            trip.update_column(:transportation, new_method)
        when '3' 
            date_found = false
            while not date_found
                puts "The current start date is #{trip.start_date}/ Please enter a new start date (YYYY/MM/DD) for #{trip.name}."
                new_date = gets.chomp
                date = Date.parse(new_date)
                puts "\nThe start date has changed from #{trip.start_date} to #{date}. Is this correct? (Y/N)"
                user_response = gets.chomp
                if user_response.downcase == 'y'
                    date_found = true
                end
            end
            puts "\nHow many days did you spend on the trip #{trip.name}?"
            duration = gets.chomp.to_i
            trip.update_column(:start_date, date)
            trip.update_column(:end_date, date+duration)
        when  '4'
            stop_information(trip)
        when '5'
            system "clear"
            main_menu($user)
        else
            puts "\nInvalid Response. Please enter a number from 1-5."
        end
    end
end


def stop_information(trip)
    stops = trip.stops
    puts "\nWhich stop would you like to edit?"
    trip.list_stops_by_location_name
    puts "#{stops.length+1}. Add a stop"
    puts "\nPlease choose a option: (1 - #{stops.length+1})"
    user_input = gets.chomp
    stop = stops[user_input.to_i-1]
    if user_input.to_i <= stops.length && user_input.to_i>0
        while true
            puts "\nWhat would you like to change?"
            puts "1. Change Rating"
            puts "2. Description"
            puts "3. Go back to the main menu"
            user_choice = gets.chomp 
            case user_choice 

            when '1'
                puts "\nPlease enter a new rating (1-10) for this stop:"
                while true
                change_rating = gets.chomp.to_i
                    if change_rating <= 0
                    puts "Invalid entry. Please enter a number from 1 to 10"
                    elsif change_rating > 10
                    puts "The rating can only be from 1-10. The rating has been set to 10."
                        break
                    else
                        break
                    end
                end
                puts "\nThe rating has changed from #{stop.rating} to #{change_rating.clamp(1,10)}"
                stop.update_column(:rating, change_rating.clamp(1,10))
            when '2'
                puts "\nPlease enter a new description for this stop:"
                change_desc = gets.chomp
                puts "\nYou have updated the description to:"
                puts "      #{change_desc}"
                stop.update_column(:description, change_desc)
            when '3'
                system "clear"
                main_menu($user)
            else
                puts "\nInvalid Response. Please try again."
            end
        end
    elsif user_input.to_i == stops.length+1
        create_locations(trip)
    else 
        puts "\nInvalid Response. Please choose a valid stop."
        stop_information(trip)
    end

end


#helper methods
def capitalize(string)
    array = string.split(" ")
    array.map {|word| word.capitalize}.join(" ")
end

#helper methods for enter_new_trip
def create_locations(new_trip)
    puts "\nWhich city did you visit on this trip?"
        location_name = gets.chomp
    puts "\nWhich state or country was it in?"
        location_statecountry = gets.chomp
        existing_location = 
            Location.find_by(
                city_name: capitalize(location_name), 
                state_or_country: capitalize(location_statecountry)
                )
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
    puts "\nHow would you rate this stop? (1-10)?"
    while true
        user_rating = gets.chomp.to_i
        if user_rating <= 0
            puts "Invalid entry. Please enter a number from 1 to 10"
        elsif user_rating > 10 
            puts "The rating can only be from 1-10. The rating has been set to 10."
            break
        else 
            break
        end
    end
    puts "\nPlease write a description for this stop."
    user_description = gets.chomp
    Stop.create(
        trip_id: trip.id,
        location_id: location.id,
        rating: user_rating,
        description: user_description
        )
end


def another_stop?(new_trip)
    puts "\nDid you visit another stop on this trip? (Y/N)"
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
    puts "\n#{index+1}. #{location.city_name}, #{location.state_or_country}"
    }
end

def go_back_to_menu?(user)
    puts "\nDo you want to go back to the main menu? (Y/N)?"
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









def display
    puts "
    ████████╗██████╗  █████╗ ██╗   ██╗███████╗██╗         ████████╗██████╗  █████╗  ██████╗██╗  ██╗███████╗██████╗ 
    ╚══██╔══╝██╔══██╗██╔══██╗██║   ██║██╔════╝██║         ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
       ██║   ██████╔╝███████║██║   ██║█████╗  ██║            ██║   ██████╔╝███████║██║     █████╔╝ █████╗  ██████╔╝
       ██║   ██╔══██╗██╔══██║╚██╗ ██╔╝██╔══╝  ██║            ██║   ██╔══██╗██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
       ██║   ██║  ██║██║  ██║ ╚████╔╝ ███████╗███████╗       ██║   ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║
       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚══════╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
                                                                                                                   
    "
#     puts "
#                                                          |
#                                                    --====|====--
#                                                          |  

#                                                     .-""""""-. 
#                                                   .'__________'. 
#                                                   /_/_|__|__|_\_\
#                                                  ;'-._       _.-';
#                             ,--------------------|    `-. .-'    |--------------------,
#                              ``""--..__    ___   ;       '       ;   ___    __..--""``
#                                       `""-// \\.._\             /_..// \\-"`
#                                           \\_//    '._       _.'    \\_//
#                                            `"`        ``---``        `"`
# '"
end

def greeting
    puts "Welcome to Travel Tracker! Do you have an account? (Y/N)"
end

def ask_for_username(user_response)
    if user_response == 'Y'
        puts "Please enter username"
        user_input = gets.chomp
        user = User.find_by username: user_input
        puts "Welcome #{user.name}!"
    elsif user_response == 'N'
        puts "create account"
    end
end

def find_user
end

def create_account
end



def main_menu
    puts "1. Enter a new Trip"
    puts "2. Find all of you trips and update any trip" # list of trips we can 
    #have another menu with 1. View Stops for a trip 
    #2. Update trip. 
    #3. Delete Trip 
    puts "3. Find all of the states/countries you have visited"
    puts "4. Delete Account"
end

def enter_new_trip
end

def find_trips
end

def find_all_states_and_countries
end

def delete_account
end







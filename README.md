# Trip Tracker : Go. See. Write.

![alt text](https://github.com/slee713/Trip_Tracker/blob/master/Screen%20Shot%202020-07-30%20at%203.03.53%20PM.png)

Flatiron School Module 1 Group Project. 

## Project Details

Trip Tracker is a command line application that allows a user to:

1. Create an account and store the user information
2. Enter a new trip with the following information
  a. Trip Name
    b. Transportation Method
    c. Start Date
    d. End Date
    e. Add Multiple Stops with the following information
        - Location city name, and state/country 
        - rating for that stop
        - description for the stop
3. View all of his/her trip informatioin
4. Update a trip/stop information
5. Delete a Trip including all of the stops related to that trip
6. Find all of the unique states/countries the user has visited
6. Delete account and all of the trips and stops associated with that account


## Installation Instructions

1. Clone the respository to your computer
2. Run `bundle install` to install all required Gems.
3. Run `rake db:migrate` to migrate and create all of the tables
4. Run `rake db:seed` to load the seeded data from db/seeds.rb file
5. Run `ruby bin/run.rb`

  **Resource:** [https://github.com/slee713/Trip_Tracker]

  Additional gems used:
          - `rainbow - https://github.com/sickill/rainbow`
  


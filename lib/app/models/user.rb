class User < ActiveRecord::Base
    has_many :trips

    def find_trips
        Trip.all.find_all {|trip| trip.user_id == self.id}
    end

    def find_all_locations
        locations = []
        trips = find_trips
        trips.each do |trip|
            Stop.where(trip_id: trip.id).each do |stop|  
            locations << Location.find(stop.location_id)
            end
        end
        locations
    end

    def list_trips
        puts "My Trips:"
        self.find_trips.each_with_index {|trip, index| 
        puts "#{index +1}. #{trip.name} - #{trip.start_date}"
    }
    end

end


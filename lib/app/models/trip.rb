class Trip < ActiveRecord::Base
    belongs_to :users
    has_many :locations, through: :stops

    def stops
        Stop.where(trip_id: self.id)
    end

    def list_stops_by_location_name
        stops.each_with_index do |stop, index|
            puts "#{index +1}. #{Location.find(stop.location_id).city_name}"
        end
    end

    def stop_information
        stops.each_with_index do |stop, index|
            puts "#{index+1}. #{Location.find(stop.location_id).city_name} 
            Rating: #{stop.rating}. Description: #{stop.description}"
        end
    end
        

    def duration
        (self.end_date - self.start_date).to_i
    end

end
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

    def view_information
        puts "Name: #{self.name}"
        puts "Transportation: #{self.transportation}"
        puts "Start Date: #{self.start_date}"
        puts "End Date: #{self.end_date}"
        puts "Duration: #{(self.end_date - self.start_date).to_i} days"
    end
        

    def duration
        (self.end_date - self.start_date).to_i
    end

end
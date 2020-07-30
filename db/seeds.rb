User.destroy_all
Trip.destroy_all
Stop.destroy_all
Location.destroy_all
#create users
steven_lee = User.create(name:"Steven Lee", username: "slee713")
roan_bascoe = User.create(name: "Roan Bascoe", username:"rbascoe")
steven_mcallister = User.create(name: "Steven McAllister", username: "steved1mac")

visiting_michael = Trip.create(
    name: "Visiting Michael", 
    user_id: steven_lee.id, 
    transportation: "car", 
    start_date: Date.parse("July 20, 2018"),
    end_date: Date.parse("July 28, 2018")
)

roans_trip = Trip.create(
    name: "Disneyworld",
    user_id: roan_bascoe.id,
    transportation: "fly",
    start_date: Date.parse("July 10, 2007"),
    end_date: Date.parse("August 2, 2007")
)

steven_m_trip = Trip.create(
    name:"My Trip",
    user_id: steven_mcallister.id,
    transportation: "train",
    start_date: Date.parse("August 19, 2019"),
    end_date: Date.parse("August 22, 2019")
)

vacation_to_seattle = Trip.create(
    name: "Wonderland 2019",
    user_id: steven_lee.id,
    transportation: "fly",
    start_date: Date.parse("August 10, 2019"),
    end_date: Date.parse("August 19, 2019")
)

#Locations


philadelphia = Location.create(
    city_name: "Philadelphia", 
    state_or_country: "Pennsylvania"
    )

boston = Location.create(
    city_name: "Boston",
    state_or_country: "Massachusetts"
    )

portland = Location.create(
    city_name: "Portland",
    state_or_country: "Maine"
)

orlando = Location.create(
    city_name: "Orlando",
    state_or_country: "Florida"
)

los_angeles = Location.create(
    city_name: "Los Angeles",
    state_or_country: "California"
)

oakland = Location.create(
    city_name: "Oakland",
    state_or_country: "California"
)

san_francisco = Location.create(
    city_name: "San Francisco",
    state_or_country: "California"
)

mt_rainier = Location.create(
    city_name: "Mount Rainier",
    state_or_country: "Washington"
)

seattle = Location.create(
    city_name: "Seattle",
    state_or_country: "Washington"
)

#Stops

steven1_stop_1 = Stop.create(
    trip_id: visiting_michael.id,
    location_id: philadelphia.id,
    rating: 8,
    description: "I stopped by Philadelphia to eat some cheesesteaks and to get a break from driving"
)

steven1_stop_2 = Stop.create(
    trip_id: visiting_michael.id,
    location_id: boston.id,
    rating: 9,
    description: "We picked up my brother and spent the day in Boston"
)
steven1_stop_3 = Stop.create(
    trip_id: visiting_michael.id,
    location_id: portland.id,
    rating: 10,
    description: "Spent a couple days in portland. Had the best oysters and lobster roll"
)

roan_bascoe_stop = Stop.create(
    trip_id: roans_trip.id,
    location_id: orlando.id,
    rating: 7,
    description: "It was magical but pricey"
)

steven_m_stop1 = Stop.create(
    trip_id: steven_m_trip.id,
    location_id: los_angeles.id,
    rating: 8,
    description: "Stay off the 504"
)

steven_m_stop2 = Stop.create(
    trip_id: steven_m_trip.id,
    location_id: oakland.id,
    rating: 9,
    description: "I love skyline drive"
)

steven_m_stop3 = Stop.create(
    trip_id: steven_m_trip.id,
    location_id: san_francisco.id,
    rating: 6,
    description: "Visited the Golden Gate Bridge"
)

steven4_stop1 = Stop.create(
    trip_id: vacation_to_seattle.id,
    location_id: mt_rainier.id,
    rating: 10,
    description: "Went hiking for 7 days around Mount Rainier"
)

steven4_stop1 = Stop.create(
    trip_id:vacation_to_seattle.id,
    location_id: seattle.id,
    rating: 9,
    description: "Spent 2 days in Seattle sight seeing and eating great food"
)
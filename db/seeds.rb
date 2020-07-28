
#create users
# steven_lee = User.create(name:"Steven Lee", username: "slee713")
# roan_bascoe = User.create(name: "Roan Bascoe", username:"rbascoe")
# steven_mcallister = User.create(name: "Steven McAllister", username: "steved1mac")

# visiting_michael = Trip.create(
#     name: "Visiting Michael", 
#     user_id: 1, 
#     transportation: "car", 
#     start_date: Date.parse("July 20, 2018"),
#     end_date: Date.parse("July 28, 2018")
# )

# roans_trip = Trip.create(
#     name: "Disneyworld",
#     user_id: 2,
#     transportation: "fly",
#     start_date: Date.parse("July 10, 2007"),
#     end_date: Date.parse("August 2, 2007")
# )

# steven_m_trip = Trip.create(
#     name:"My Trip",
#     user_id: 3,
#     transportation: "train",
#     start_date: Date.parse("August 19, 2019"),
#     end_date: Date.parse("August 22, 2019")
# )

vacation_to_seattle = Trip.create(
    name: "Wonderland 2019",
    user_id: 1,
    transportation: "fly",
    start_date: Date.parse("August 10, 2019"),
    end_date: Date.parse("August 19, 2019")
)


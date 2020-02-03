# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#shelters 
shelter_1 = Shelter.create!(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: 80202)
shelter_2 = Shelter.create!(name: "Meg's Shelter", address: "50 Main Street", city: "Hershey", state: "PA", zip: 17033)
shelter_3 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
shelter_4 = Shelter.create!(name: "Smart Friends League", address: "456 Sample St", city: "Denver", state: "CO", zip: 80220)

# Shelter.create(name: 'Alamo Lake Dog Haven', address: '12 Ferry Avenue', city: 'Cincinnati', state: 'Ohio', zip: 45219)
# Shelter.create(name: 'Alcova Dog Shelter', address: '67 Jefferson Lane', city: 'El Paso', state: 'Texas', zip: 79901)
# Shelter.create(name: 'Alpine Northeast Dog Haven', address: '25 Jessie Avenue', city: 'Springfield', state: 'Massachusetts', zip: 21151)
# Shelter.create(name: 'Anoka Dog Sanctuary', address: '60 Loma Street', city: 'Dallas', state: 'Texas', zip: 75287)
# Shelter.create(name: 'Antelope Hills Dog Sanctuary', address: '41 Renfrow Street', city: 'Tucson', state: 'Arizona', zip: 85705)
# Shelter.create(name: 'Atlantic City Dog Sanctuary', address: '59 Pine Valley Street', city: 'Sarasota', state: 'Florida', zip: 34232)
# Shelter.create(name: 'Beluga Dog Shelter', address: '72 Strong Lane', city: 'Indianapolis', state: 'Indiana', zip: 46218)
# Shelter.create(name: 'Birch Creek Dog Haven', address: '11 Corning Avenue', city: 'Milwaukee', state: 'Wisconsin', zip: 53203)
# Shelter.create(name: 'Bondurant Dog Shelter', address: '78 Pillsbury Lane', city: 'Colorado Springs', state: 'Colorado', zip: 80951)
# Shelter.create(name: 'Boulder Dog Sanctuary', address: '43 Lake Buena Vista Street', city: 'Rochester', state: 'New York', zip: 14608)
# Shelter.create(name: 'Bowden Dog Sanctuary', address: '54 Meyer Street', city: 'Buffalo', state: 'New York', zip: 14208)
# Shelter.create(name: 'Brownlee Dog Haven', address: '25 New Holland Avenue', city: 'Minneapolis', state: 'Minnesota', zip: 55403)
# Shelter.create(name: 'Brundage Dog Haven', address: '4 Zarephath Avenue', city: 'Reno', state: 'Nevada', zip: 89521)
# Shelter.create(name: 'Butterfield Dog Sanctuary', address: '44 Topock Street', city: 'Las Vegas', state: 'Nevada', zip: 89107)
# Shelter.create(name: 'Canova Dog Haven', address: '13 Junction City Avenue', city: 'Baton Rouge', state: 'Louisiana', zip: 70836)
# Shelter.create(name: 'Carter Dog Sanctuary', address: '53 Kingston Street', city: 'Allentown', state: 'Pennsylvania', zip: 18105)
# Shelter.create(name: 'Cave Dog Haven', address: '24 Weed Avenue', city: 'Brooklyn', state: 'New York', zip: 11212)
# Shelter.create(name: 'City of the Sun Dog Sanctuary', address: '61 Paxson Street', city: 'Ogden', state: 'Utah', zip: 84404)
# Shelter.create(name: 'Cobre Dog Haven', address: '20 Burton Avenue', city: 'Worcester', state: 'Massachusetts', zip: 41610)
# Shelter.create(name: 'Conchas Dam Dog Shelter', address: '81 East Amana Lane', city: 'Mission Viejo', state: 'California', zip: 92692)

#shelter_1 pets 
sparky = shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'Male', description: "Fun but no so nice",  adoptable: true)
peppo  = shelter_1.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'Female', description: "Basically a naked molerat",  adoptable: true)

# #shelter_2 pets 
peter = shelter_2.pets.create!(name: "Peter", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg", approximate_age: 3, sex: "Male", description: "Sooooo cute!", adoptable: true)


# Pet.create(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', age_approx: 5, sex: 'male', breed: 'West Highland White Terrier', adoptable: true, shelter_id: 67)
# Pet.create(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', age_approx: 13, sex: 'female', breed: 'Mexican Hairless', adoptable: false, shelter_id: 81)
# Pet.create(name: 'Chayo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/pomeranian_196.jpg', age_approx: 12, sex: 'male', breed: 'Pomeranian', adoptable: true, shelter_id: 77)
# Pet.create(name: 'Busby', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/brittany_spaniel_138.jpg', age_approx: 4, sex: 'female', breed: 'Brittany Spaniel', adoptable: true, shelter_id: 93)
# Pet.create(name: 'Orsino', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/irish_terrier_90.jpg', age_approx: 2, sex: 'female', breed: 'Irish Terrier', adoptable: false, shelter_id: 59)
# Pet.create(name: 'Rajnal', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/bernese_mountain_dog_82.jpg', age_approx: 10, sex: 'female', breed: 'Bernese Mountain Dog', adoptable: true, shelter_id: 64)
# Pet.create(name: 'Zico', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/whippet_171.jpg', age_approx: 7, sex: 'female', breed: 'Whippet', adoptable: true, shelter_id: 29)
# Pet.create(name: 'Diva-Channel', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/entlebucher_92.jpg', age_approx: 6, sex: 'female', breed: 'Entlebucher', adoptable: true, shelter_id: 69)
# Pet.create(name: 'Asal', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/papillon_19.jpg', age_approx: 15, sex: 'female', breed: 'Papillon', adoptable: true, shelter_id: 25)
# Pet.create(name: 'Genie', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/briard_38.jpg', age_approx: 1, sex: 'female', breed: 'Briard', adoptable: true, shelter_id: 54)
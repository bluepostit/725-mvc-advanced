require_relative 'patient'
require_relative 'room'

bob = Patient.new(name: 'bob')

nameless = Patient.new
# p nameless

sally = Patient.new(name: 'sally', cured: true)

mike = Patient.new(blood_type: 'A', name: 'mike')
p bob
p sally
p mike


room = Room.new(capacity: 2)
p room

# Add patients to the room
begin
  room.add_patient(sally)
  room.add_patient(bob)
  p room

  puts "The room has #{room.patients.count} patients"
  room.add_patient(mike)
rescue Room::RoomFullException
  puts 'Sorry, could not add patient; the room is full'
end

puts "The room has #{room.patients.count} patients"

puts "------------\n\n"
room.patients.each do |patient|
  puts "#{patient.name} is in the room"
  puts "Room: #{patient.room}"
end

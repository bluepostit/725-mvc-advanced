require_relative 'patient_repository'
require_relative 'room_repository'
require_relative 'patient'

def print_patients(repo)
  repo.all.each do |patient|
    puts "id: #{patient.id} - name: #{patient.name}"
  end
end

room_repo = RoomRepository.new('data/rooms.csv')
patient_repo = PatientRepository.new('data/patients.csv', room_repo)
print_patients(patient_repo)

sue = Patient.new(name: 'sue')
patient_repo.add(sue)
joe = Patient.new(name: 'joe')
patient_repo.add(joe)

puts "----------\n\n"

print_patients(patient_repo)

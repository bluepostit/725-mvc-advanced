# State
#  - patients (array)
#  - room repository instance!
# Behavior
#  - all
#  - add patient
#  - load CSV (private)
#  - save CSV (private)

require 'csv'
require_relative 'patient'

class PatientRepository
  def initialize(csv_file_path, room_repository)
    @csv_file_path = csv_file_path
    @room_repository = room_repository
    @patients = []
    @next_id = 1
    load_csv
  end

  def add(patient)
    patient.id = @next_id
    @next_id += 1
    @patients << patient
    save_csv
  end

  def all
    @patients
  end

  private

  def load_csv
    csv_options = {
      headers: :first_row,
      header_converters: :symbol
    }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # row is a hash-like object!
      row[:cured] = row[:cured] == 'true'
      row[:id] = row[:id].to_i
      # fetch Room instance from the RoomRepository instance we have
      room = @room_repository.find(row[:room_id].to_i)
      # add this Room instance to the hash for the new Patient.
      row[:room] = room

      patient = Patient.new(row)
      room.add_patient(patient)
      @patients << patient
    end
    @next_id = @patients.last.id + 1 unless @patients.empty?
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << %w[id name cured blood_type room_id]
      @patients.each do |patient|
        # NOTE: not patient.room! patient.room.id
        csv << [patient.id, patient.name, patient.cured?, patient.blood_type, patient.room.id]
      end
    end
  end
end

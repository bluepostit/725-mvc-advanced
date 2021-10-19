# State
# - patients
# - capacity
# - clean?
# Behavior
# - add patient
# - remove patient
# - full?

class Room
  class RoomFullException < Exception
  end

  attr_reader :patients, :capacity
  attr_accessor :id

  def initialize(attributes = {})
    # an array of Patient objects!
    @id = attributes[:id]
    @patients = attributes[:patients] || []
    @capacity = attributes[:capacity] || 0
    @clean = attributes[:clean] || false
  end

  def add_patient(patient)
    fail RoomFullException, 'The room is full' if full?

    @patients << patient
    # add THIS Room instance as the patient's room
    patient.room = self
  end

  def full?
    @patients.length >= @capacity
  end

  def clean?
    @clean
  end

  def clean!
    @clean = true
  end
end

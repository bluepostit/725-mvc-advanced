# State
#  - rooms (array)
# Behavior
#  - all
#  - add room
#  - find by ID!
#  - load CSV (private)
#  - save CSV (private)

require 'csv'
require_relative 'room'

class RoomRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @rooms = []
    load_csv
  end

  def add(room)
    @rooms << room
  end

  def all
    @rooms
  end

  # Find and return the Room instance which has the given id!
  def find(id)
    @rooms.find { |room| room.id == id }
  end

  private

  def load_csv
    csv_options = {
      headers: :first_row,
      header_converters: :symbol
    }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # row is a hash-like object!
      row[:clean] = row[:clean] == 'true'
      row[:id] = row[:id].to_i
      row[:capacity] = row[:capacity].to_i
      @rooms << Room.new(row)
    end
  end
end

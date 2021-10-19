# State
# - name
# - cured?
# Behavior
# - cure!

class Patient
  attr_reader :name, :blood_type
  attr_accessor :room, :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @cured = attributes[:cured] || false
    @blood_type = attributes[:blood_type]
    @room = attributes[:room]
  end

  def cured?
    @cured
  end

  def cure!
    @cured = true
  end
end

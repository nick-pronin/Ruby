require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :capacity

  def initialize (weight, height, width, total_units)
    super(weight, height, width, total_units, :cargo)
    @capacity = total_units.to_i
  end
end

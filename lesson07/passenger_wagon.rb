require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :seats

  def initialize (weight, height, width, total_units)
    super(weight, height, width, total_units, :passenger)
    @seats = total_units.to_i
  end
end

require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :seats

  ZERO_ERROR = 'Все места заняты'.freeze

  def initialize (weight, height, width, total_units)
    super(weight, height, width, total_units, :passenger)
    @seats = total_units.to_i
  end

  def take_unit # метод, который "занимает места" в вагоне (по одному за раз)
    raise ZERO_ERROR if available_units.zero?
    @occupied_units += 1
  end
end

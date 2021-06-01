require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :capacity

  ZERO_ERROR = 'Весь объем занят'.freeze
  OVER_SPACE_ERROR = 'Невозможно заполнить такой объем, выберите меньшее значение'.freeze

  def initialize (length = 13870 , height = 4700, width = 3300, total_units)
    super(length, height, width, total_units, :cargo)
    @capacity = total_units.to_i
  end
end

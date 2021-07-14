# frozen_string_literal: true

require_relative 'wagon'

class CargoWagon < Wagon
  ZERO_ERROR = 'Весь объем занят'
  OVER_SPACE_ERROR = 'Невозможно заполнить такой объем, выберите меньшее значение'
  def initialize(options = {})
    super(:cargo)
    @total_units = options[:total_units] || 2000
    @length = options[:length] || 13_870
    @height = options[:height] || 4700
    @width = options[:width] || 3300
  end
end

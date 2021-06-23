# frozen_string_literal: true

require_relative 'wagon'

class PassengerWagon < Wagon
  ZERO_ERROR = 'Все места заняты'

  def initialize(options = {})
    super(:passenger)
    @total_units = options[:total_units] || 100
    @length = options[:length] || 13_870
    @height = options[:height] || 4700
    @width = options[:width] || 3300
  end

  def take_unit
    raise ZERO_ERROR if available_units.zero?

    @occupied_units += 1
  end
end

# frozen_string_literal: true

require_relative 'manufacturing_company'

class Wagon
  attr_accessor :length, :height, :width, :type, :total_units, :occupied_units

  include ManufacturingCompany

  ZERO_ERROR = 'Нет свободного пространства'
  OVER_SPACE_ERROR = 'Доступно меньше пространства'

  def initialize(type, options = {})
    @type = type
    @total_units = options[:total_units]
    @length = options[:length]
    @height = options[:height]
    @width = options[:width]
    @occupied_units = 0
  end

  def available_units
    @total_units - @occupied_units
  end

  def take_unit(unit)
    raise ZERO_ERROR if available_units.zero?
    raise OVER_SPACE_ERROR if available_units < unit

    @occupied_units += unit
  end
end

require_relative 'manufacturing_company'

class Wagon
  attr_reader :weight, :height, :width, :type, :total_units, :occupied_units # :total_units - общее количество, :occupied_units - метод, который возвращает кол-во занятых мест в вагоне
  include ManufacturingCompany

  ZERO_ERROR = 'Нет свободного пространства'
  OVER_SPACE_ERROR = 'Доступно меньше пространства'

  def initialize(weight, height, width, total_units, type)
    @weight = weight.to_i
    @height = height.to_i
    @width = width.to_i
    @total_units = total_units.to_i
    @type = type
    @occupied_units = 0
  end

  def available_units
    @total_units - @occupied_units # метод, возвращающий кол-во свободных мест в вагоне.
  end

  def take_unit(unit) # метод, который "занимает места" в вагоне (по одному за раз)
    raise ZERO_ERROR if available_units.zero?
    raise OVER_SPACE_ERROR if available_units < unit
    @occupied_units += unit
  end
end

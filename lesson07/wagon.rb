require_relative 'manufacturing_company'

class Wagon
  attr_reader :weight, :height, :width, :type, :total_units, :occupied_units # :total_units - общее количество, :occupied_units - метод, который возвращает кол-во занятых мест в вагоне
  include ManufacturingCompany

  def initialize(weight, height, width, total_units, type)
    @weight = weight.to_i
    @height = height.to_i
    @width = width.to_i
    @total_units = total_units.to_i
    @type = type
    @occupied_units = 0
  end

  protected

  def free_units
    @total_units - @occupied_units # метод, возвращающий кол-во свободных мест в вагоне.
  end

  def take_unit # метод, который "занимает места" в вагоне (по одному за раз)
    @occupied_units = @total_units - 1
    @total_units -= 1
  end
end

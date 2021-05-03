require_relative 'manufacturing_company'

class Wagon
  attr_reader :weight, :height, :width, :type
  include ManufacturingCompany

  def initialize(weight, height, width, type)
    @weight = weight
    @height = height
    @width = width
    @type = type
  end
end

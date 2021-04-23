class Wagon
  attr_reader :weight, :height, :width, :type

  def initialize(weight, height, width, type)
    @weight = weight
    @height = height
    @width = width
    @type = type
  end
end

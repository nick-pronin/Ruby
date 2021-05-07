class CargoWagon < Wagon
  attr_reader :capacity

  def initialize (weight, height, width, capacity)
    super(weight, height, width, :cargo)
    @capacity = capacity
  end
end

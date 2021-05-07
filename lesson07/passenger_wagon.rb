class PassengerWagon < Wagon
  attr_reader :seats

  def initialize (weight, height, width, seats)
    super(weight, height, width, :passenger)
    @seats = seats
  end
end

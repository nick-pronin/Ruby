require_relative "train"

class PassengerTrain < Train

  def initialize(number)
    super(number, :passenger)
  end

  def attach_wagon(wagon)
    if wagon.is_a?(PassengerWagon)
      super
    else
      puts 'Выбран неподходящий тип вагона'
    end
  end
end

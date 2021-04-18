class Train
  attr_accessor :wagons, :speed
  attr_reader :number, :type

  def initialize(number, wagons)
    @number = number.to_s
    puts 'Выберите тип поезда: passenger или cargo'
    @type = gets.chomp
    @wagons = wagons.to_i
    @speed = 0
  end

  def increase_speed
    @speed += 5
  end

  def stop_train
    @speed = 0
  end

  def attach_wagon
    if @speed == 0
      @wagons += 1
    else
      puts 'Сначала остановите поезд'
    end
  end

  def unhook_wagon
    if @speed == 0 && @wagons > 0
      @wagons -= 1
    else
      puts 'Сначала остановите поезд или проверьте наличие вагонов'
    end
  end

  def get_route(route)
    @route = route
    @current_station = 0
    current_station.take_train(self)
  end

  def current_station
    @route.stations[@current_station]
  end

  def next_station
    @route.stations[@current_station + 1]
  end

  def previous_station
    @route.stations[@current_station - 1] if @current_station > 0
  end

  def move_forvard
    if next_station
      current_station.send_train(self)
      next_station.take_train(self)
      @current_station += 1
    end
  end

  def move_backward
    if previous_station
      current_station.send_train(self)
      previous_station.take_train(self)
      @current_station -= 1
    end
  end
end

class Train
  attr_accessor :wagons, :speed
  attr_reader :number, :type

  def initialize(number, wagons) # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
    @number = number.to_s
    puts "Выберите тип поезда: passenger или cargo"
    @type = gets.chomp
    @wagons = wagons.to_i
    @speed = 0
  end

  def increase_speed # Может набирать скорость
    @speed += 5
  end

  def stop_train # Может тормозить (сбрасывать скорость до нуля)
    @speed = 0
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.

  def attach_wagon
    if @speed == 0
      @wagons += 1
    else
      puts "Сначала остановите поезд"
    end
  end

  def unhook_wagon
    if @speed == 0 && @wagons > 0
      @wagons -= 1
    else
      puts "Сначала остановите поезд или проверьте наличие вагонов"
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
end

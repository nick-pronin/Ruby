class Train
  attr_accessor :wagons, :speed
  attr_reader :number, :type

  def initialize(number, type, wagons) # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
    @number = number.to_s
    @type = type
    @wagons = wagons.to_i
    @speed = 0
  end

  def increase_speed # Может набирать скорость
    self.speed += 5
  end

  def stop_train # Может тормозить (сбрасывать скорость до нуля)
    self.speed = 0
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.

  def attach_wagon
    if @speed == 0
      self.wagons += 1
    else
      puts "Сначала остановите поезд"
    end
  end

  def unhook_wagon
    if @speed == 0 && @wagons > 0
      self.wagons -= 1
    else
      puts "Сначала остановите поезд или проверьте наличие вагонов"
    end
  end
end

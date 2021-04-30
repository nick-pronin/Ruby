require_relative 'manufacturing_company'
require_relative 'instance_counter'

class Train
  attr_reader :number, :type, :wagons, :speed, :route
  include ManufacturingCompany
  include InstanceCounter

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number.to_s
    @type = type
    @wagons = []
    @speed = 0
    @@trains[number] = self
    register_instances
  end

  def increase_speed
    @speed += 5
  end

  def stop_train
    @speed = 0
  end

  def attach_wagon(wagon)
    self.wagons << wagon if self.type == wagon.type && @speed == 0
  end

  def unhook_wagon
    if @speed == 0 && @wagons.size > 0
      @wagons.delete_at(-1)
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

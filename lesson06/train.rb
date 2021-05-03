require_relative 'manufacturing_company'
require_relative 'instance_counter'

class Train
  attr_reader :number, :type, :wagons, :speed, :route
  include ManufacturingCompany
  include InstanceCounter

  NUMBER_FORMAT = /^[a-z\d]{3}\-[a-z\d]{2}$/i
  FORMAT_ERROR = 'Номер не соотвутствует формату. Введите номер в правильном формате: XXX(-XX)'
  TRAIN_EXISTS_ERROR = "Поезд с таким номером уже существует"
  TRAIN_TYPES = %i[cargo passenger].freeze

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    validate!
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
    @wagons.delete_at(-1) if @speed == 0 && @wagons.size > 0
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

  def validate!

    if @number !~ NUMBER_FORMAT
      raise ArgumentError, FORMAT_ERROR
    end

    unless TRAIN_TYPES.include?(@type)
      raise ArgumentError, 'Неправильный тип поезда'
    end

    raise TRAIN_EXISTS_ERROR if Train.find(@number)
  end
end

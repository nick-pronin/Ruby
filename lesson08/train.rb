# frozen_string_literal: true

require_relative 'manufacturing_company'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  attr_reader :number, :type, :wagons, :speed, :route

  include ManufacturingCompany
  include InstanceCounter
  include Validation

  NUMBER_FORMAT = /^[a-z\d]{3}-[a-z\d]{2}$/i.freeze
  FORMAT_ERROR = 'Номер не соотвутствует формату. Введите номер в правильном формате: XXX(-XX)'
  TRAIN_EXISTS_ERROR = 'Поезд с таким номером уже существует'
  TRAIN_TYPES = %i[cargo passenger].freeze

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
    @wagons << wagon if @type == wagon.type && @speed.zero?
  end

  def unhook_wagon
    @wagons.delete_at(-1) if @speed.zero? && @wagons.size.positive?
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
    @route.stations[@current_station - 1] if @current_station.positive?
  end

  def move_forvard
    return unless next_station

    current_station.send_train(self)
    next_station.take_train(self)
    @current_station += 1
  end

  def move_backward
    return unless previous_station

    current_station.send_train(self)
    previous_station.take_train(self)
    @current_station -= 1
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) }
  end
end

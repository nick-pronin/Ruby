require_relative 'validation'
require_relative 'menu'
class Station
  attr_reader :trains, :name
  include Validation

  @@stations = []

  def self.find_station(name)
    @@stations.find { |station| return station if station.name.capitalize == name.capitalize }
  end

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name.strip.capitalize
    validate!
    @trains = []
    @@stations << self
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def show_trains
    @trains.each { |train| puts "#{train}" }
  end

  def show_trains_type(type)
    @trains.select { |train| train.type == type }
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  def validate!
    raise ArgumentError, 'Название станции не указано' if @name.nil?

    if self.class.find_station(@name)
      raise ArgumentError
    end
  rescue
    puts INPUT_AGAIN_MENU
  end
end

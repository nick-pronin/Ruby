class Station
  attr_reader :trains, :name
  include Validation

  @@stations = []

  def self.find(name)
    @@stations.find { |station| return station if station.name == name }
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

  def validate!
    raise ArgumentError, 'Название станции не указано' if @name.nil?
    
    if self.class.find(@name)
      raise ArgumentError, 'Станция с таким названием уже существует'
    end
  end
end

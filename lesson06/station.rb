class Station
  attr_reader :trains, :name
  include Validation

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name.capitalize
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
    @trains.select{ |train| train.type == type }
  end

  def validate!
    raise ArgumentError, 'Название станции не указано' if @name.nil?
    raise ArgumentError, 'Название станции не может начинаться или заканчиваться пустым значением' if @name[0] || @name[-1] == ' '
    raise ArgumentError, 'Станция с таким названием уже существует' if self.class.find(@name)
  end
end

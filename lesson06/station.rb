class Station
  attr_reader :trains, :name

  NAME_OF_STATION = /^[a-z]|[а-я]/i
  #{}/^[а-я]{1}|[a-z]{1}\d{3}[а-я]{2}|[a-z]{2}/i #

  @@stations = []

  def self.all
    @@stations
  end

  def initialize
    @name = name.capitalize
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
    @trains.each { |train| puts "На станции находятся нижеуказанные поезда: #{train}" }
  end

  def show_trains_type(type)
    @trains.select{ |train| train.type == type }
  end
end

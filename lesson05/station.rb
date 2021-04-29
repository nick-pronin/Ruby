class Station
  attr_reader :trains, :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
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

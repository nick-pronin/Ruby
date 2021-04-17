class Station
  attr_accessor :station_name
  attr_reader :trains

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def take_train(train)
    self.trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains
    @trains.each { |train| puts "На станции находятся нижеуказанные поезда: #{train}" }
  end
end

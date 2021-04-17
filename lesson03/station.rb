class Station
  attr_accessor :station_name
  attr_reader :trains

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def take_train
    self.trains << @train
  end
end

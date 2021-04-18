class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    unless @stations.include?(station)
      @stations.insert(-2, station)
    else
      puts "Станция уже есть в маршруте"
    end
  end
end

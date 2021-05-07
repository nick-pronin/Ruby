class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    unless @stations.include?(station)
      @stations.insert(-2, station)
    else
      puts 'Станция уже есть в маршруте'
    end
  end

  def remove_station(station)
    unless station == @stations.first && station == @stations.last
      @stations.delete(station)
    else
      puts 'Нельзя убрать из маршрута начальную и конечную станции'
    end
  end

  def show_stations
    puts 'Станции на маршруте:'
    @stations.each { |station| puts station.name }
  end
end

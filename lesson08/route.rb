# frozen_string_literal: true

class Route
  attr_reader :stations, :name

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @name = "#{first_station.name} - #{last_station.name}"
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def remove_station(station)
    @stations.delete(station) unless station == @stations.first && station == @stations.last
  end

  def show_stations
    puts 'Станции на маршруте:'
    @stations.each { |station| puts station.name }
  end
end

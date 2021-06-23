# frozen_string_literal: true

def create_station
  puts CREATE_STATION_MENU
  name_station = gets.chomp
  show_station_management_menu if name_station == '0'

  @stations.each do |st|
    if st.name == name_station.capitalize
      puts INPUT_AGAIN_MENU
      return create_station
    end
  end
  station = Station.new(name_station)
  puts CREATE_STATION_DONE
  @stations << station
  show_station_management_menu
end

def delete_station
  puts CHOOSE_STATION_MENU
  station = select_station
  if station.zero?
    show_station_management_menu
  else
    @stations.delete(station)
    puts DELETE_STATION_MENU
    show_station_management_menu
  end
end

def select_first_station
  puts CHOOSE_FIRST_STATION_ROUTE_MENU
  select_station
end

def select_last_station
  puts CHOOSE_LAST_STATION_ROUTE_MENU
  select_station
end

def select_station
  @stations.each.with_index(1) do |station, index|
    puts "#{index} - #{station.name}"
  end
  station = gets.to_i
  return 0 if station.zero?

  @stations[station - 1]
end

def show_station_and_train_on_station
  show_stations
  index_station = gets.to_i
  show_train_on_station(index_station - 1)
  show_station_management_menu
end

def show_stations
  puts 'Выберите станцию для отображения списка поездов на ней:'
  @stations.each.with_index(1) do |station, index|
    puts "#{index} - #{station.name}"
  end
end

def show_train_on_station(index)
  puts NO_TRAINS_ON_STATION if @stations[index].trains.empty?
  @stations[index].trains.each do |train|
    puts "Поезд № #{train.number}"
  end
end

# frozen_string_literal: true

def create_route
  first_station = select_first_station
  show_route_management_menu if first_station.zero?
  last_station = select_last_station
  show_route_management_menu if last_station.zero?

  if first_station == last_station
    puts EQUAL_ROUTES_MENU
    return
  end

  if first_station.nil? || last_station.nil?
    puts NO_ROUTES_MENU
    return
  end

  @routes.each do |route|
    if route.stations.first.name == first_station.name && route.stations.last.name == last_station.name
      puts INPUT_AGAIN_MENU
      create_route
    else
      puts CREATE_ROUTE_DONE
      new_route = Route.new(first_station, last_station)
      puts "#{new_route.stations.first.name} - #{new_route.stations.last.name}"
      @routes << new_route
      show_route_management_menu
    end
  end
end

def show_routes
  puts 'Список маршрутов:'
  routes_list
end

def assign_route_to_train
  route = select_route
  train = select_train
  train.get_route(route)
  puts "Поезд №#{train.number} находится на маршруте #{route.stations.first.name} - #{route.stations.last.name}"
end

def select_route
  puts 'Выберите маршрут:'
  routes_list
  choice_route = gets.to_i
  @routes[choice_route - 1]
end

def routes_list
  @routes.each.with_index(1) do |route, index|
    puts "#{index}: #{route.stations.first.name} - #{route.stations.last.name}"
    puts 'Станции на маршруте:'
    route.stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
  end
end

def remove_station_from_route
  route = select_route
  station = select_station
  route.remove_station(station)
end

def add_station_to_route
  route = select_route
  station = select_station
  route.add_station(station)
end

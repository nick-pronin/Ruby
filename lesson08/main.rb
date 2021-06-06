require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'validation'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'menu'

class Main
  attr_accessor :trains, :stations, :routes

  def initialize
    puts WELCOME_MENU
    @trains = []
    @routes = []
    @stations = []
    seeds
  end

  def start
    loop do
      # sleep(3)
      puts SHOW_MAIN_MENU
      choice = gets.to_i
      break if choice.zero?

      user_choice(choice)
    end
  end

  protected

  def user_choice(choice)
    case choice
    when 1 then show_station_management_menu
    when 2 then show_route_management_menu
    when 3 then show_trains_management_menu
    end
  end

  def show_station_management_menu
    puts STATIONS_MANAGEMENT_MENU
    choice = gets.to_i
    return if choice == 0
    user_choice_for_stations(choice)
  end

  def show_route_management_menu
    puts ROUTES_MANAGEMENT_MENU
    choice = gets.to_i
    return if choice == 0
    user_choice_for_routes(choice)
  end

  def show_trains_management_menu
    puts TRAINS_MANAGEMENT_MENU
    choice = gets.to_i
    return if choice == 0
    user_choice_for_trains(choice)
  end

  def user_choice_for_routes(choice)
    case choice
    when 1 then create_route
    when 2 then add_station_to_route
    when 3 then remove_station_from_route
    when 4 then show_routes
    end
  end

  def user_choice_for_stations(choice)
    case choice
    when 1 then create_station
    when 2 then delete_station
    when 3 then show_station_and_train_on_station
    end
  end

  def user_choice_for_trains(choice)
    case choice
    when 1 then create_train
    when 2 then delete_train
    when 3 then add_wagon_to_train
    when 4 then remove_wagon_from_train
    when 5 then show_wagons_train
    when 6 then train_move
    end
  end

#------------------------Station Methods------------------------

  def create_station
    puts CREATE_STATION_MENU
    name_station = gets.chomp
    show_station_management_menu if name_station == '0'

    @stations.each do |st|
      if st.name === name_station.capitalize
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
    if station == 0
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
    puts "Выберите станцию для отображения списка поездов на ней:"
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

#------------------------Train Methods------------------------

  def create_train
    train_number = get_train_number

    if train_number !~ NUMBER_FORMAT
      puts FORMAT_ERROR
      return create_train
    end

    train_type = get_train_type

    return create_train if train_number == '0' || train_type == '0'

    return if train_number.nil? || train_type.nil?

    @trains.each do |train|
      if train.number == train_number
        puts INPUT_AGAIN_MENU
        return create_train
      end
    end

    train = Train.new(train_number, train_type)
    puts CREATE_TRAIN_DONE
    @trains << train
    appoint_route(train)
  end

  def delete_train
    puts CHOOSE_TRAIN_MENU
    train = select_train

    if train == 0
      show_trains_management_menu
    else
      @trains.delete(train)
      puts DELETE_TRAIN_MENU
      show_trains_management_menu
    end
  end

  def get_train_number
    puts GET_TRAIN_NUMBER_MENU
    train_number = gets.chomp

    return show_trains_management_menu if train_number == '0'
    return train_number
  end

  def get_train_type
    puts GET_TRAIN_TYPE
    train_type = gets.to_i

    case train_type
    when 1 then :passenger
    when 2 then :cargo
    end
  end

  def appoint_route(train)
    if @routes.empty?
      puts "Сначала создайте маршрут"
      create_route
    else
      puts "Выберите маршрут:"
      @routes.each.with_index(1) do |route, index|
        puts "#{index}, если хотите выбрать маршрут #{route.name}"
    end

    answer = @routes[gets.to_i - 1]
    puts "Поезд начал движение по маршруту #{answer.name}"
    train.get_route(answer)
  end
end

  def train_move
    train = select_train
    puts SELECT_DIRECTION_MENU
    direction = gets.to_i

    return if train.nil? || train.route.nil?
    case direction
    when 1 then train_move_forvard(train)
    when 2 then train_move_backward(train)
    end
    puts "Поезд №#{train.number} передвинулся на станцию #{train.current_station.name}"
  end

def train_move_forvard(train)
  if train.next_station.nil?
    puts "Поезд находится на станции прибытия"
  else
    train.move_forvard
    puts "Поезд прибыл на станцию #{train.current_station.name}"
  end
end

def train_move_backward(train)
  if train.previous_station.nil?
    puts "Поезд находится на станции отправления"
  else
    train.move_backward
    puts "Поезд прибыл на станцию #{train.current_station.name}"
  end
end

  def add_wagon_to_train
    train = select_train
    wagon = create_wagon

    train.attach_wagon(wagon)
    puts "К поезду №#{train.number} добавлен вагон. Количество вагонов равно #{train.wagons.size}"
  end

  def remove_wagon_from_train
    train = select_train
    train.unhook_wagon
    puts "У поезда №#{train.number} вагонов осталось: #{train.wagons.size}"
  end

  def create_wagon
    puts GET_WAGON_TYPE
    wagon_type = gets.to_i
    case wagon_type
    when 1 then passenger_wagon
    when 2 then cargo_wagon
    end
  end

  def cargo_wagon
    puts GET_CARGO_WAGON_CAPACITY
    capacity = gets.to_i
    CargoWagon.new(capacity)
  end

  def passenger_wagon
    puts GET_PASSENGER_WAGON_SEATS
    seats = gets.to_i
    PassengerWagon.new(seats)
  end

  def select_train
    puts CHOOSE_TRAIN_MENU
    @trains.each.with_index(1) do |train, index|
      puts "#{index} - #{train.number}"
    end
    choice_train = gets.to_i
    return 0 if choice_train == 0
    @trains[choice_train - 1]
  end

  def show_wagons_train
    train = select_train

    puts "Количество вагонов у поезда #{train.number}:"
    puts "#{train.wagons.size}"
    train.wagons.each.with_index(1) do |wagon, index|
        puts "#{index} - Грузоподъемность(объем): #{wagon.capacity}, можно загрузить: свободно мест: #{wagon.available_units}" if wagon.type == :cargo
        puts "#{index} - Количество пассажирских мест: #{wagon.seats}, свободно мест: #{wagon.available_units}" if wagon.type == :passenger
      end
  end

##------------------------Route Methods------------------------

  def create_route
    first_station = select_first_station
    show_route_management_menu if first_station == 0
    last_station = select_last_station
    show_route_management_menu if last_station == 0

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
    puts "Поезд №#{train.number} находится на маршруте #{route.stations.first.name} - #{route.stations.last.name}(Станция #{route.stations.first.name})"
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
      puts "Станции на маршруте:"
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

  def seeds
    novorosiysk = Station.new('новороссийск')
    moscow = Station.new('москва')
    krasnodar = Station.new('краснодар')
    cargo_train1 = CargoTrain.new('123-ff')
    passenger_train1 = PassengerTrain.new('246-gg')
    cargo_wagon1 = CargoWagon.new(1000, 5, 5, 10000)
    cargo_wagon2 = CargoWagon.new(1200, 6, 6, 10000)
    passenger_wagon1 = PassengerWagon.new(1000, 5, 5, 100)
    passenger_wagon2 = PassengerWagon.new(1100, 5, 5, 110)
    passenger_train1.attach_wagon(passenger_wagon1)
    passenger_train1.attach_wagon(passenger_wagon2)
    cargo_train1.attach_wagon(cargo_wagon1)
    cargo_train1.attach_wagon(cargo_wagon2)
    novorosiysk.take_train(cargo_train1)
    novorosiysk.take_train(passenger_train1)
    route = Route.new(novorosiysk, moscow)
    @stations.push(novorosiysk, moscow, krasnodar)
    @trains.push(cargo_train1, passenger_train1)
    route
    @routes << route
  end
end

  Main.new.start

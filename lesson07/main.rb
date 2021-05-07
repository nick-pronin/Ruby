require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'validation'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Main
  attr_reader :trains

  def initialize
    puts WELCOME_MENU
    @trains = []
    @routes = []
    @stations = []
  end

  def start
    loop do
      show_menu
      choice = gets.to_i
      break if choice.zero?

      user_choice(choice)
    end
  end

  private

  def show_menu
    puts 'Выберите пункт меню, 0 - для выхода:'
    puts '1 - Создать станцию'
    puts '2 - Создать поезд'
    puts '3 - Создать маршрут'
    puts '4 - Назначить маршрут поезду'
    puts '5 - Добавить вагоны к поезду'
    puts '6 - Отцепить вагоны от поезда'
    puts '7 - Переместить поезд по маршруту'
    puts '8 - Просмотреть список станций и список поездов на станции'
    puts '9 - Посмотреть список маршрутов'
  end

  def user_choice(choice)
    case choice
    when 1 then create_station
    when 2 then create_train
    when 3 then menu_create_route
    when 4 then assign_route_to_train
    when 5 then add_wagon_to_train
    when 6 then remove_wagon_from_train
    when 7 then move_train
    when 8 then show_station_and_train_on_station
    when 9 then show_routes
    end
  end

  def create_station
    begin
    loop do

        puts "Введите название станции или 0 для выхода:"
        name_station = gets.chomp
        break if name_station == '0'

        station = Station.new(name_station)
        @stations << station
      rescue RuntimeError => e
        puts e.message
        retry
      end
    end
  end

  def create_train
    loop do
      begin
        train_number = get_train_number
        break if train_number == '0'

        train_type = get_train_type

        return if train_number.nil? || train_type.nil?

        train = Train.new(train_number, train_type)
        puts "Создан поезд под номером #{train.number}"
        @trains << train
      rescue RuntimeError => e
        puts e.message
        retry
      end
      show_success_train_create(train) if train.valid?
    end

  end


def show_success_train_create(train)
puts "Поезд номер #{train.number} типа #{train.class} успешно создан"
end

  def get_train_number
    puts 'Введите номер поезда или 0 для выхода:'
    train_number = gets.chomp

    return train_number
  end

  def get_train_type
    puts 'Выберите тип поезда:'
    puts '1 - Пассажирский'
    puts '2 - Грузовой'
    train_type = gets.to_i

    case train_type
    when 1 then :passenger
    when 2 then :cargo
    end
  end

  def menu_create_route
    loop do
      show_menu_create_route
      menu_create_route_choice = gets.to_i
      break if menu_create_route_choice == 0
      case menu_create_route_choice
      when 1 then create_route
      when 2 then add_station_to_route
      when 3 then remove_station_from_route
      end
    end
  end

  def show_menu_create_route
     puts 'Выберите пункт меню, 0 для выхода'
     puts '1 - Создать маршрут'
     puts '2 - Добавить станцию в маршрут'
     puts '3 - Удалить станцию из маршрута'
  end

  def create_route
    begin
      first_station = select_first_station
      last_station = select_last_station

      return if first_station == last_station
      return if first_station.nil? || last_station.nil?

      @routes << Route.new(first_station, last_station)
    rescue RuntimeError => e
      puts e.message
      retry
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

  def select_first_station
    puts 'Выберите начальную станцию:'
    select_station
  end

  def select_last_station
    puts 'Выберите конечную станцию:'
    select_station
  end

  def select_station
    @stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
    station = gets.to_i
    return if station.zero?
    @stations[station - 1]
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

  def move_train
    train = select_train
    direction = select_direction
    return if train.nil? || train.route.nil?
    case direction
    when 1 then train.move_forvard
    when 2 then train.move_backward
    end
    puts "Поезд №#{train.number} передвинулся на станцию #{train.current_station.name}"
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
    puts "У поезда №#{train.number} осталось #{train.wagons.size} вагонов"
  end

  def create_wagon
    puts 'Выберите тип вагона:'
    puts '1 - Грузовой'
    puts '2 - Пассажирский'
    wagon_type = gets.to_i
    case wagon_type
    when 1 then cargo_wagon
    when 2 then passenger_wagon
    end
  end

  def cargo_wagon
    puts 'Введите массу, высоту, ширину и грузоподъемность:'
    weight = gets.to_i
    height = gets.to_i
    width = gets.to_i
    capacity = gets.to_i
    CargoWagon.new(weight, height, width, capacity)
  end

  def passenger_wagon
    puts 'Введите массу, высоту, ширину и количество пассажирских мест:'
    weight = gets.to_i
    height = gets.to_i
    width = gets.to_i
    seats = gets.to_i
    PassengerWagon.new(weight, height, width, seats)
  end

  def select_route
    puts 'Выберите маршрут:'
    routes_list
    choice_route = gets.to_i
    @routes[choice_route - 1]
  end

  def select_train
    puts 'Выберите поезд'
    @trains.each.with_index(1) do |train, index|
      puts "#{index} - #{train.number}"
    end
    choice_train = gets.to_i
    @trains[choice_train - 1]
  end

  def routes_list
    @routes.each.with_index(1) do |route, index|
      puts "#{index}: #{route.stations.first.name} - #{route.stations.last.name}"
    end
  end

  def select_direction
    puts 'Выберите направление:'
    puts '1 - Вперёд'
    puts '2 - Назад'
    gets.to_i
  end

  def show_station_and_train_on_station
    show_stations
    index_station = gets.to_i
    show_train_on_station(index_station - 1)
  end

  def show_stations
    puts "Выберите станцию для отображения списка поездов на ней:"
    @stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
  end

  def show_train_on_station(index)
    @stations[index].trains.each do |train|
      puts "Номер поезда #{train.number}"
    end
  end


  WELCOME_MENU =
  <<~WELCOME_WORDS
  ------------------------------------------------------------
  |                                                          |
  |               Приветствую тебя в ООО "РЖД"               |
  |                                                          |
  ------------------------------------------------------------
  WELCOME_WORDS
  .freeze

  end

  Main.new.start

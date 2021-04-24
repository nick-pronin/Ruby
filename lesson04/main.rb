require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Main

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
end

def user_choice(choice)
  case choice
  when 1 then create_station
  when 2 then create_train
  end
end

def create_station
  loop do
    puts "Введите название станции или 0 для выхода:"
    name_station = gets.chomp
    break if name_station == '0'

    station = Station.new(name_station)
    @stations << station
  end
end

def create_train
  loop do
    train_number = get_train_number
    break if train_number == '0'

    train_type = get_train_type

    return if train_number.nil? || train_type.nil?

    train = Train.new(train_number, train_type)
    @trains << train
  end
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
  when 1 then PassengerTrain
  when 2 then CargoTrain
  end

  return train_type
end

CHOOSE_MENU =
<<~CHOOSE_MENU
------------------------------------------------------------
|                                                          |
|               Привет, дорогой пользователь!              |
|               Приветствую тебя в ООО "РЖД"               |
|                                                          |
------------------------------------------------------------
CHOOSE_MENU
.freeze

WELCOME_MENU =
<<~WELCOME_WORDS
------------------------------------------------------------
|                                                          |
|               Привет, дорогой пользователь!              |
|               Приветствую тебя в ООО "РЖД"               |
|                                                          |
------------------------------------------------------------
WELCOME_WORDS
.freeze

end

Main.new.start

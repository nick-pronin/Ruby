# frozen_string_literal: true

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
require_relative 'station_methods'
require_relative 'train_methods'
require_relative 'route_methods'

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
    return if choice.zero?

    user_choice_for_stations(choice)
  end

  def show_route_management_menu
    puts ROUTES_MANAGEMENT_MENU
    choice = gets.to_i
    return if choice.zero?

    user_choice_for_routes(choice)
  end

  def show_trains_management_menu
    puts TRAINS_MANAGEMENT_MENU
    choice = gets.to_i
    return if choice.zero?

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

  def seeds
    novorosiysk = Station.new('новороссийск')
    moscow = Station.new('москва')
    krasnodar = Station.new('краснодар')
    cargo_train1 = CargoTrain.new('123-ff')
    passenger_train1 = PassengerTrain.new('246-gg')
    cargo_wagon1 = CargoWagon.new
    cargo_wagon2 = CargoWagon.new
    passenger_wagon1 = PassengerWagon.new
    passenger_wagon2 = PassengerWagon.new
    passenger_train1.attach_wagon(passenger_wagon1)
    passenger_train1.attach_wagon(passenger_wagon2)
    cargo_train1.attach_wagon(cargo_wagon1)
    cargo_train1.attach_wagon(cargo_wagon2)
    novorosiysk.take_train(cargo_train1)
    novorosiysk.take_train(passenger_train1)
    route = Route.new(novorosiysk, moscow)
    @stations.push(novorosiysk, moscow, krasnodar)
    @trains.push(cargo_train1, passenger_train1)
    @routes << route
  end
end

Main.new.start

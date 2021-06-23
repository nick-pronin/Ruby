# frozen_string_literal: true

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

  if train.zero?
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
    puts 'Сначала создайте маршрут'
    create_route
  else
    puts 'Выберите маршрут:'
    @routes.each.with_index(1) do |route, index|
      puts "#{index}, если хотите выбрать маршрут #{route.name}"
    end
  end

  answer = @routes[gets.to_i - 1]
  puts "Поезд начал движение по маршруту #{answer.name}"
  train.get_route(answer)
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
    puts 'Поезд находится на станции прибытия'
  else
    train.move_forvard
    puts "Поезд прибыл на станцию #{train.current_station.name}"
  end
end

def train_move_backward(train)
  if train.previous_station.nil?
    puts 'Поезд находится на станции отправления'
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
  return 0 if choice_train.zero?

  @trains[choice_train - 1]
end

def show_wagons_train
  train = select_train

  puts "Количество вагонов у поезда #{train.number}:"
  puts train.wagons.size.to_s
  train.wagons.each.with_index(1) do |wagon, index|
      puts "#{index} - Грузоподъемность(объем): #{wagon.capacity}, можно загрузить: свободно мест: #{wagon.available_units}" if wagon.type == :cargo
      puts "#{index} - Количество пассажирских мест: #{wagon.seats}, свободно мест: #{wagon.available_units}" if wagon.type == :passenger
  end
end

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def show_trains
    @trains.each { |train| puts "На станции находятся нижеуказанные поезда: #{train}" }
  end

  def show_trains_type(type)
    @trains.each { |train| puts "#{train}" if train.type == type }
  end
end

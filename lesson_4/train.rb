class Train
  attr_reader :route, :cars, :id
  attr_accessor :speed

  def initialize(id)
    @id = id
    @cars = []
    @speed = 0
  end
  
  def set_route(route)
    @route = route
    unless current_station.nil?
      current_station.send_train(self)
    end
    route.stations[0].receive_train(self)
  end

  def stop
    self.speed = 0
  end

  def current_station
    route.stations.find {|station| station.trains.include?(self)}
  end

  def previous_station
    route.stations[route.stations.find_index(current_station) - 1]
  end

  def next_station
    route.stations[route.stations.find_index(current_station) + 1]
  end

  def go_to_next_station
    next_stop = next_station
    current_station.send_train(self)
    next_stop.receive_train(self)
  end

  def go_to_previous_station
    next_stop = previous_station
    current_station.send_train(self)
    next_stop.receive_train(self)
  end

  def add_car(car)
    cars.append(car) if (types_match?(car) and speed.zero?)
  end

  def delete_car(car)
    cars.delete(car) if speed.zero?
  end

  def type
    :general
  end

  private

  # helper method for this class, it is not used in child classes
  def types_match?(car)
    type == car.type
  end

end
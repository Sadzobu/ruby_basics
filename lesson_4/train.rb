class Train
  attr_reader :route, :cars
  attr_accessor :speed

  def initialize(id)
    @id = id
    @cars = []
    @speed = 0
  end

  def set_route(route)
    @route = route
    route.stations[0].receive_train(self)
  end

  def stop
    self.speed = 0
  end

  def cur_station
    route.stations.each {|station| return station if station.trains.include?(self)}
  end

  def prev_station
    route.stations[route.stations.find_index(cur_station) - 1]
  end

  def next_station
    route.stations[route.stations.find_index(cur_station) + 1]
  end

  def goto_next_station
    ns = next_station
    cur_station.send_train(self)
    ns.receive_train(self)
  end

  def goto_prev_station
    ps = prev_station
    cur_station.send_trasin(self)
    ps.receive_train(self)
  end

  def add_car(car)
    cars.append(car) if (types_match?(car) and speed.zero?)
  end

  def del_car(car)
    cars.delete(car) if speed.zero?
  end

  def type
    :general
  end

  protected

  def types_match?(car)
    type == car.type
  end

end
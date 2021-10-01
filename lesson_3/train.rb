class Train
  attr_reader :type, :route, :num_cars
  attr_accessor :speed

  def initialize(id, type, num_cars)
    @id = id
    @type = type
    @num_cars = num_cars
    @speed = 0
  end

  def set_route(route)
    @route = route
    route.stations[0].receive_train(self)
  end

  def stop
    self.speed = 0
  end

  def add_car
    self.num_cars += speed == 0 ? 1 : 0
  end

  def remove_car  
    self.num_cars -= speed == 0 ? 1 : 0
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

end
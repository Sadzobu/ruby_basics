class Train
  attr_reader :type, :route, :cur_station, :next_station, :prev_station
  attr_accessor :speed, :num_cars, :cur_pos

  def initialize(id, type, num_cars)
    @id = id
    @type = type
    @num_cars = num_cars
    @speed = 0
  end

  def set_route(route)
    @route = route
    @cur_pos = 0
    @cur_station = self.route.stations[0]
    @prev_station = nil
    @next_station = self.route.stations[1]
  end

  def stop
    self.speed = 0
  end

  def add_car
    self.num_cars += self.speed == 0 ? 1 : 0
  end

  def remove_car  
    self.num_cars -= self.speed == 0 ? 1 : 0
  end

  def goto_next_station
    self.cur_pos += 1
    self.cur_station = self.route.stations[self.cur_pos]
    self.prev_station = self.cur_pos > 0 ? self.route.stations[self.cur_pos - 1] : nil
    self.next_station = self.cur_pos < self.route.stations.length ? self.route.stations[self.cur_pos + 1] : nil
  end

  def goto_prev_station
    self.cur_pos -= 1
    self.cur_station = self.route.stations[self.cur_pos]
    self.prev_station = self.cur_pos > 0 ? self.route.stations[self.cur_pos - 1] : nil
    self.next_station = self.cur_pos < self.route.stations.length ? self.route.stations[self.cur_pos + 1] : nil
  end

end
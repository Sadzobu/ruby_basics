class Route
  attr_accessor :stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [start_station, end_station]
  end

  def add_station(name)
    self.stations.insert(-2, name)
  end

  def del_station(name)
    self.stations.delete(name)
  end

  def show_stations
    self.stations[...-1].each {|station| print "#{station}->"} 
    puts self.stations[-1]
  end
end
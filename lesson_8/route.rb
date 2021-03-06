# frozen_string_literal: true

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [start_station, end_station]
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station)
  end

  def show_stations
    stations[0..-2].each { |station| print "#{station.name}->" }
    puts stations[-1].name
  end
end

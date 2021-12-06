# frozen_string_literal: true

require_relative 'manufacturing_company'
require_relative 'instance_counter'
require_relative 'pass_block'
require_relative 'validation'

class Train
  include ManufacturingCompany
  include InstanceCounter
  include Validation
  include PassBlock

  attr_reader :route, :cars, :id
  attr_accessor :speed

  ID_PATTERN = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  validate :id, :presence
  validate :id, :type, String
  validate :id, :format, ID_PATTERN

  @@trains = {}

  def initialize(id)
    @id = id
    @cars = []
    @speed = 0
    validate!
    @@trains[id] = self
    register_instance
  end

  def self.find(id)
    @@trains[id]
  end

  def route=(route)
    @route = route
    current_station&.send_train(self)
    route.stations[0].receive_train(self)
  end

  def stop
    self.speed = 0
  end

  def current_station
    route.stations.find { |station| station.trains.include?(self) }
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
    cars.append(car) if types_match?(car) && speed.zero?
  end

  def delete_car(car)
    cars.delete(car) if speed.zero?
  end

  def train_type
    :general
  end

  def each_car(&block)
    pass_block(cars, &block)
  end

  private

  # helper methods for this class, they are not used in child classes
  def types_match?(car)
    type == car.type
  end

  def number?(string)
    true if Float(string)
  rescue StandardError
    false
  end
end

# frozen_string_literal: true

require_relative 'car'

class PassengerCar < Car
  def occupy
    self.occupied_space += 1
  end

  def type
    @type = :passenger
  end
end

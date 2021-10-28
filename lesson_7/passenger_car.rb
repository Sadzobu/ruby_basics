require_relative 'car.rb'

class PassengerCar < Car
  def occupy()
    self.occupied_space += 1
  end

  def type
    @type = :passenger
  end
end
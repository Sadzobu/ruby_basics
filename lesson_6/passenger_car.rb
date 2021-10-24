class PassengerCar
  include ManufacturingCompany
  
  attr_reader :type

  def initialize
    @type = :passenger
  end
end
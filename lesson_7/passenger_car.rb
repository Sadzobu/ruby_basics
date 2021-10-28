class PassengerCar
  include ManufacturingCompany
  
  attr_reader :type, :occupied_seats

  def initialize(seats)
    @type = :passenger
    @seats = seats
    @occupied_seats = 0
  end

  def occupy
    self.occupied_seats += 1
  end

  def vacant_seats
    self.seats - self.occupied_seats
  end

  private

  attr_reader :seats
  attr_writer :occupied_seats
end
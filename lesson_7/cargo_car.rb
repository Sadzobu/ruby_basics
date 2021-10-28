require_relative 'car.rb'

class CargoCar < Car
  def occupy(space)
    self.occupied_space += space
  end

  def type
    @type = :cargo
  end
end
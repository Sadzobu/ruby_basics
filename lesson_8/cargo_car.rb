# frozen_string_literal: true

require_relative 'car'

class CargoCar < Car
  def occupy(space)
    self.occupied_space += space
  end

  def type
    @type = :cargo
  end
end

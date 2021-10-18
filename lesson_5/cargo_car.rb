class CargoCar
  include ManufacturingCompany

  attr_reader :type

  def initialize
    @type = :cargo
  end
end
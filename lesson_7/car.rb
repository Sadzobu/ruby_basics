class Car
  include ManufacturingCompany

  attr_reader :occupied_space, :type

  def initialize(space)
    @space = space
    @occupied_space = 0
  end

  def available_space
    space - occupied_space
  end

  def type
    @type = :general
  end

  protected

  attr_reader :space
  attr_writer :occupied_space
end
class CargoCar
  include ManufacturingCompany

  attr_reader :type, :occupied_volume

  def initialize(volume)
    @type = :cargo
    @volume = volume
    @occupied_volume = 0
  end

  def occupy(volume)
    self.occupied_volume += volume
  end

  def available_volume
    self.volume - self.occupied_volume
  end

  private

  attr_reader :volume
  attr_writer :occupied_volume
end
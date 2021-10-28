class Station
  include InstanceCounter
  include Validation
  include PassBlock

  attr_reader :trains, :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations.append(self)
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def receive_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def passenger_trains()
    return trains.select {|train| train.type == :passenger}
  end

  def cargo_trains()
    return trains.select {|train| train.type == :cargo}
  end

  protected

  def validate!
    raise "Staion name must be at least 3 symbols long!" if name.length < 3
  end

end

class Station
  include InstanceCounter

  attr_reader :trains, :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations.append(self)
    register_instance
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

end

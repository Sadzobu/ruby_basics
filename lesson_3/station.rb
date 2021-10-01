class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def passenger_trains()
    return trains.select {|train| train.type == 'passenger'}
  end

  def cargo_trains()
    return trains.select {|train| train.type == 'cargo'}
  end

end
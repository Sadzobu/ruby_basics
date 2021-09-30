class Station
  attr_accessor :trains, :passenger_trains, :cargo_trains

  def initialize(name)
    @name = name
    @trains = []
    @passenger_trains = []
    @cargo_trains =[]
  end

  def receive_train(train)
    self.trains << train
    self.passenger_trains << train if train.type == 'passenger'
    self.cargo_trains << train if train.type == 'cargo'
  end

  def send_train(train)
    self.trains.delete(train)
  end
end
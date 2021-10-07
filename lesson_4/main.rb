require_relative 'cargo_car.rb'
require_relative 'passenger_car.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'station.rb'
require_relative 'route.rb'

trains = []
stations = []
routes = []

puts "Welcome to RailRoad Control Simulation!"
while true
  puts "#############################################################"
  puts "Please, choose one of the options below:"
  puts "Type 'C', to Create new object (Train, Station, Route)"
  puts "Type 'U', to update object (Train, Station)"
  puts "Type 'S', to Show information about object (Station, Route)"
  puts "Type 'E', to Exit"
  user_input = gets.chomp()
  case user_input
  when 'C' 
    puts "Please, choose what object to create:"
    puts "Type 'T', to create new Train"
    puts "Type 'S', to create new Station"
    puts "Type 'R', to create new Route"
    user_input = gets.chomp()
    case user_input
    when 'T'
      puts "Please, choose a train type:"
      puts "1: Cargo"
      puts "2: Passenger"
      user_input = gets.chomp()
      case user_input
      when '1'
        puts "Please, enter train number:"
        user_input = gets.chomp()
        trains.append(CargoTrain.new(user_input))
        puts "Cargo train with number #{user_input} created!"
      when '2'
        puts "Please, enter train number:"
        user_input = gets.chomp()
        trains.append(PassengerTrain.new(user_input))
        puts "Passenger train with number #{user_input} created!"
      end
    when 'S'
      puts "Please, enter station name:"
      user_input = gets.chomp()
      stations.append(Station.new(user_input))
      puts "Station \"#{user_input}\" was created"
    when 'R'
      puts "Please, enter route's first station name:"
      user_input = gets.chomp()
      start_station = stations.find {|station| station.name == user_input}
      if start_station.nil?
        puts "This station does not exist, can't create route"
      end
      puts "Please, enter route's  last station name:"
      user_input = gets.chomp()
      end_station = stations.find {|station| station.name == user_input}
      if end_station.nil?
        puts "This station does not exist, can't create route"
      end
      routes.append(Route.new(start_station, end_station))
      puts "Created route #{start_station.name} -> #{end_station.name}"
    end
  when 'E'
    return
  end
end

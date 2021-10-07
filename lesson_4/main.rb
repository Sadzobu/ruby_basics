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


#test data
t1 = CargoTrain.new("534")
t2 = PassengerTrain.new("322")

s1 = Station.new("Domo")
s2 = Station.new("Avto")

r = Route.new(s1, s2)

t1.set_route(r)
t2.set_route(r)
trains << t1 << t2
stations << s1 << s2
routes << r
#test data end

while true
  puts "\e[H\e[2J"
  puts "Welcome to RailRoad Control Simulation!"
  puts "#############################################################"
  puts "Please, choose one of the options below:"
  puts "Type 'C', to Create new object (Train, Station, Route)"
  puts "Type 'U', to update object (Train, Station)"
  puts "Type 'S', to Show information about object (Station, Route)"
  puts "Type 'E', to Exit"
  user_input = gets.chomp()
  case user_input
  when 'C'
    puts "\e[H\e[2J" 
    puts "Please, choose what object to create:"
    puts "Type 'T', to create new Train"
    puts "Type 'S', to create new Station"
    puts "Type 'R', to create new Route"
    user_input = gets.chomp()
    case user_input
    when 'T'
      puts "\e[H\e[2J"
      puts "Please, choose a train type:"
      puts "1: Cargo"
      puts "2: Passenger"
      user_input = gets.chomp()
      case user_input
      when '1'
        puts "\e[H\e[2J"
        puts "Please, enter train number:"
        user_input = gets.chomp()
        trains.append(CargoTrain.new(user_input))
        puts "Cargo train with number #{user_input} created!"
        puts "Press anything to continue:"
        user_input = gets
      when '2'
        puts "\e[H\e[2J"
        puts "Please, enter train number:"
        user_input = gets.chomp()
        trains.append(PassengerTrain.new(user_input))
        puts "Passenger train with number #{user_input} created!"
        puts "Press anything to continue:"
        user_input = gets
      end
    when 'S'
      puts "\e[H\e[2J"
      puts "Please, enter station name:"
      user_input = gets.chomp()
      stations.append(Station.new(user_input))
      puts "Station \"#{user_input}\" was created"
      puts "Press anything to continue:"
      user_input = gets
    when 'R'
      puts "\e[H\e[2J"
      puts "Please, enter route's first station name:"
      user_input = gets.chomp()
      start_station = stations.find {|station| station.name == user_input}
      if start_station.nil?
        puts "This station does not exist, can't create route"
        puts "Press anything to continue:"
        user_input = gets
        next
      end
      puts "Please, enter route's  last station name:"
      user_input = gets.chomp()
      end_station = stations.find {|station| station.name == user_input}
      if end_station.nil?
        puts "This station does not exist, can't create route"
        puts "Press anything to continue:"
        user_input = gets
        next
      end
      routes.append(Route.new(start_station, end_station))
      puts "Created route #{start_station.name} -> #{end_station.name}"
      puts "Press anything to continue:"
      user_input = gets
    end
  when 'U'
    puts "\e[H\e[2J"
    puts "Enter 'T', to add or remove cars from train"
    puts "Enter 'S', to add or remove stations from route"
    puts "Enter 'M', to move train on the route"
    user_input = gets.chomp()
  when 'S'
    puts "\e[H\e[2J"
    puts "Current stations are:"
    stations.each {|station| puts "#{station.name}"}
    puts "Enter station name, to show trains on that station:"
    user_input = gets.chomp()
    current_station = stations.find {|station| station.name == user_input}
    if current_station.nil?
        puts "This station does not exist, can't show trains"
        puts "Press anything to continue:"
        user_input = gets
        next
    end
    puts "Enter 'A', to show all trains on station"
    puts "Enter 'C', to show all cargo trains on station"
    puts "Enter 'P', to show all passenger trains on station"
    user_input = gets.chomp()
    case user_input
    when 'A'
      puts "\e[H\e[2J"
      puts "Trains on station \"#{current_station.name}\":"
      current_station.trains.each {|train| puts "#{train.id}"}
      puts "Press anything to continue:"
      user_input = gets
    when 'C'
      puts "\e[H\e[2J"
      puts "Cargo trains on station \"#{current_station.name}\":"
      current_station.cargo_trains.each {|train| puts "#{train.id}"}
      puts "Press anything to continue:"
      user_input = gets
    when 'P'
      puts "\e[H\e[2J"
      puts "Passenger trains on station \"#{current_station.name}\":"
      current_station.passenger_trains.each {|train| puts "#{train.id}"}
      puts "Press anything to continue:"
      user_input = gets
    end
  when 'E'
    return
  end
end

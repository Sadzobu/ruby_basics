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
s3 = Station.new("Kolomna")
s4 = Station.new("Ramenki")

r1 = Route.new(s1, s2)
r2 = Route.new(s4,s3)
r2.add_station(s1)
r2.add_station(s2)

t1.set_route(r1)
t2.set_route(r2)
trains << t1 << t2
stations << s1 << s2 << s3 << s4
routes << r1 << r2
#test data end

while true
  puts "\e[H\e[2J"
  puts "Welcome to RailRoad Control Simulation!"
  puts "#############################################################"
  puts "Please, choose one of the options below:"
  puts "Type 'C', to Create new object (Train, Station, Route)"
  puts "Type 'U', to update object (Train, Station)"
  puts "Type 'S', to Show information about object (Station)"
  puts "Type 'E', to Exit"
  user_input = gets.chomp
  case user_input
  when 'C'
    puts "\e[H\e[2J" 
    puts "Please, choose what object to create:"
    puts "Type 'T', to create new Train"
    puts "Type 'S', to create new Station"
    puts "Type 'R', to create new Route"
    user_input = gets.chomp
    case user_input
    when 'T'
      puts "\e[H\e[2J"
      puts "Please, choose a train type:"
      puts "1: Cargo"
      puts "2: Passenger"
      user_input = gets.chomp
      case user_input
      when '1'
        puts "\e[H\e[2J"
        puts "Please, enter train number:"
        user_input = gets.chomp
        trains.append(CargoTrain.new(user_input))
        puts "Cargo train with number #{user_input} created!"
        puts "Press anything to continue:"
        user_input = gets
      when '2'
        puts "\e[H\e[2J"
        puts "Please, enter train number:"
        user_input = gets.chomp
        trains.append(PassengerTrain.new(user_input))
        puts "Passenger train with number #{user_input} created!"
        puts "Press anything to continue:"
        user_input = gets
      end
    when 'S'
      puts "\e[H\e[2J"
      puts "Please, enter station name:"
      user_input = gets.chomp
      stations.append(Station.new(user_input))
      puts "Station \"#{user_input}\" was created"
      puts "Press anything to continue:"
      user_input = gets
    when 'R'
      puts "\e[H\e[2J"
      puts "Please, enter route's first station name:"
      user_input = gets.chomp
      start_station = stations.find {|station| station.name == user_input}
      if start_station.nil?
        puts "This station does not exist, can't create route"
        puts "Press anything to continue:"
        user_input = gets
        next
      end
      puts "Please, enter route's  last station name:"
      user_input = gets.chomp
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
    user_input = gets.chomp
    case user_input
    when 'T'
      puts "\e[H\e[2J"
      puts "Enter train number:"
      user_input = gets.chomp
      current_train = trains.find {|train| train.id == user_input}
      if current_train.nil?
        puts "This train does not exist"
        puts "Press anything to continue:"
        user_input = gets
        next
      end
      puts "Press 'A', to add car to train #{current_train.id}"
      puts "Press 'D', to remove car from train #{current_train.id}"
      user_input = gets.chomp
      case user_input
      when 'A'
        if current_train.type == :cargo
          current_train.add_car(CargoCar.new())
        else
          current_train.add_car(PassengerCar.new())
        end
        puts "Train #{current_train.id} now has #{current_train.cars.length} cars!"
        puts "Press anything to continue:"
        user_input = gets
      when 'D'
        if current_train.type == :cargo
          current_train.del_car(CargoCar.new())
        else
          current_train.del_car(PassengerCar.new())
        end
        puts "Train #{current_train.id} now has #{current_train.cars.length} cars!"
        puts "Press anything to continue:"
        user_input = gets
      end
    when 'S'
    when 'M'
      puts "\e[H\e[2J"
      puts "Enter train number:"
      user_input = gets.chomp
      current_train = trains.find {|train| train.id == user_input}
      if current_train.nil?
        puts "This train does not exist"
        puts "Press anything to continue:"
        user_input = gets
        next
      end
      puts "Choose a route for the train:"
      routes.each_with_index do |route, i|
        print "#{i}: "
        route.show_stations
      end
      user_input = gets.chomp.to_i
      current_train.set_route(routes[user_input])
      puts "Train #{current_train.id} is now on route #{user_input.to_s}!"
      puts "Press anything to continue:"
      user_input = gets
    end
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

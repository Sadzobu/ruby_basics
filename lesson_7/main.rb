require_relative 'manufacturing_company.rb'
require_relative 'instance_counter.rb'
require_relative 'pass_block.rb'
require_relative 'validation.rb'
require_relative 'cargo_car.rb'
require_relative 'passenger_car.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'station.rb'
require_relative 'route.rb'

def main
  trains = []
  stations = []
  routes = []

  #test data
  t1 = CargoTrain.new('12345')
  t2 = PassengerTrain.new('paa-ar')
  s1 = Station.new('Artoe')
  s2 = Station.new('Parara')
  w1 = CargoCar.new(12)
  w2 = CargoCar.new(14)
  w3 = PassengerCar.new(100)
  r1 = Route.new(s1, s2)
  r2 = Route.new(s2, s1)
  t1.add_car(w1)
  t1.add_car(w2)
  t2.add_car(w3)
  t1.set_route(r1)
  t2.set_route(r1)
  trains << t1 << t2
  stations << s1 << s2

  while true
    puts "\e[H\e[2J"
    puts "Welcome to RailRoad Control Simulation!"
    puts "#############################################################"
    puts "Please, choose one of the options below:"
    puts "Type 'C', to Create new object (Train, Station, Route)"
    puts "Type 'U', to update object (Car, Train, Station)"
    puts "Type 'S', to Show information about object (Train, Station)"
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
          begin
            puts "Please, enter train number:"
            user_input = gets.chomp
            current_train = CargoTrain.new(user_input)
          rescue RuntimeError => e
            puts e.inspect
            retry
          end
          trains.append(current_train)
          puts "Cargo train with number #{user_input} created!"
          puts "Press anything to continue:"
          user_input = gets
        when '2'
          puts "\e[H\e[2J"
          begin
            puts "Please, enter train number:"
            user_input = gets.chomp
            current_train = PassengerTrain.new(user_input)
          rescue RuntimeError => e
            puts e.inspect
            retry
          end
          trains.append(current_train)
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
      puts "Enter 'C', to change car in a train"
      puts "Enter 'T', to add or remove cars from train"
      puts "Enter 'S', to add or remove stations from route"
      puts "Enter 'M', to move train on the route"
      user_input = gets.chomp
      case user_input
      when 'C'
        current_train = show_trains_and_cars(trains)
        puts "Enter number of car to modify:"
        user_input = gets.chomp
        current_car = current_train.cars[user_input.to_i-1]
        if current_car.type == :passenger
          current_car.occupy()
          puts "This car now has #{current_car.occupied_seats} occupied seats and #{current_car.vacant_seats} vacant seats left"
        elsif current_car.type == :cargo
          puts "Enter amount of units of volume to occupy:"
          user_input = gets.chomp
          current_car.occupy(user_input.to_i)
          puts "This car now has #{current_car.occupied_volume} units of occupied volume and #{current_car.available_volume} units of available volume left"
        end
        puts "Press anything to continue:"
        user_input = gets
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
            puts "Enter number of seats in a car:"
            user_input = gets.chomp
            current_train.add_car(CargoCar.new(user_input))
          else
            puts "Enter the volume capacity of a car:"
            user_input = gets.chomp
            current_train.add_car(PassengerCar.new(user_input))
          end
          puts "Train #{current_train.id} now has #{current_train.cars.length} cars!"
          puts "Press anything to continue:"
          user_input = gets
        when 'D'
          if current_train.type == :cargo
            current_train.delete_car(current_train.cars.last)
          else
            current_train.delete_car(current_train.cars.last)
          end
          puts "Train #{current_train.id} now has #{current_train.cars.length} cars!"
          puts "Press anything to continue:"
          user_input = gets
        end
      when 'S'
        puts "\e[H\e[2J"
        puts "Choose a route to modify"
        routes.each_with_index do |route, i|
          print "#{i}: "
          route.show_stations
        end
        user_input = gets.chomp.to_i
        current_route = routes[user_input]
        puts "\e[H\e[2J"
        puts "Press 'A', to add station to route"
        puts "Press 'D', to remove station from route"
        user_input = gets.chomp
        case user_input 
        when 'A'
          puts "\e[H\e[2J"
          puts "Enter name of the station:"
          user_input = gets.chomp
          new_station = stations.find {|station| station.name == user_input}
          if new_station.nil?
            puts "This station does not exist, can't add it to route"
            puts "Press anything to continue:"
            user_input = gets
            next
          end
          current_route.add_station(new_station)
          puts "Succesfully added station! Route now looks like this:"
          current_route.show_stations
        when 'D'
          puts "\e[H\e[2J"
          puts "Enter name of the station:"
          user_input = gets.chomp
          new_station = stations.find {|station| station.name == user_input}
          if new_station.nil?
            puts "This station does not exist, can't remove it from route"
            puts "Press anything to continue:"
            user_input = gets
            next
          end
          current_route.delete_station(new_station)
          puts "Succesfully removed station! Route now looks like this:"
          current_route.show_stations
        end
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
        puts "Press 'N', to send train to the next station, on current route"
        puts "Press 'P', to send train to the previous station, on current route"
        puts "Press 'C', to change train's current route"
        user_input = gets.chomp
        case user_input
        when 'N'
          current_train.go_to_next_station
          puts "Train #{current_train.id} is now on \'#{current_train.current_station.name}\'"
          puts "Press anything to continue:"
          user_input = gets
        when 'P'
          current_train.go_to_previous_station
          puts "Train #{current_train.id} is now on \'#{current_train.current_station.name}\'"
          puts "Press anything to continue:"
          user_input = gets
        when 'C'
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
      end
    when 'S'
      puts "\e[H\e[2J"
      puts "Press 'S', to show information about train on stations"
      puts "Press 'T', to show information about cars in train"
      user_input = gets.chomp
      case user_input
      when 'S'
        puts "\e[H\e[2J"
        puts "Current stations are:"
        stations.each {|station| puts "#{station.name}"}
        puts "Enter station name, to show trains on that station:"
        user_input = gets.chomp
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
        user_input = gets.chomp
        case user_input
        when 'A'
          puts "\e[H\e[2J"
          puts "Trains on station \"#{current_station.name}\":"
          current_station.pass_block (current_station.trains) {|x| puts "#{x.type.to_s.capitalize} train with number #{x.id} has #{x.cars.length} cars."}
          puts "Press anything to continue:"
          user_input = gets
        when 'C'
          puts "\e[H\e[2J"
          puts "Cargo trains on station \"#{current_station.name}\":"
          current_station.pass_block (current_station.cargo_trains) {|x| puts "#{x.type.to_s.capitalize} train with number #{x.id} has #{x.cars.length} cars."}
          puts "Press anything to continue:"
          user_input = gets
        when 'P'
          puts "\e[H\e[2J"
          puts "Passenger trains on station \"#{current_station.name}\":"
          current_station.pass_block (current_station.passenger_trains) {|x| puts "#{x.type.to_s.capitalize} train with number #{x.id} has #{x.cars.length} cars."}
          puts "Press anything to continue:"
          user_input = gets
        end
      when 'T'
        show_trains_and_cars(trains)
        puts "Press anything to continue:"
        user_input = gets
      end
    when 'E'
      return
    end
  end
end

def show_trains_and_cars(trains)
  puts "\e[H\e[2J"
  puts "Current trains are:"
  trains.each {|train| puts "#{train.id}"}
  puts "Enter train number, to show information about cars in that train:"
  user_input = gets.chomp
  current_train = Train.find(user_input)
  car_counter = 0
  if current_train.type == :passenger
    current_train.pass_block (current_train.cars) do |x|
      car_counter += 1
      puts "Car #{car_counter} has a #{x.type.to_s} type and has #{x.occupied_seats} occupied seats and #{x.vacant_seats} vacant seats left"
    end
  elsif current_train.type == :cargo
    current_train.pass_block (current_train.cars) do |x|
      car_counter += 1
      puts "Car #{car_counter} has a #{x.type.to_s} type and has #{x.occupied_volume} units of occupied volume and #{x.available_volume} units of available volume left"
    end
  end
  current_train
end

main
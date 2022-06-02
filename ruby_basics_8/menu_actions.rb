# frozen_string_literal: true

require_relative './models/route'
require_relative './models/train'
require_relative './models/station'
require_relative './models/wagon'
require_relative './models/passenger_wagon'
require_relative './models/cargo_wagon'
require_relative './models/cargo_train'
require_relative './models/passenger_train'

# class MenuActions
class MenuActions
  def create_station
    print 'Enter the station name: '
    Station.new(gets.chomp)
    puts 'The station has been successfully created!'
  end

  def create_train
    print 'Enter the train number: '
    train_number = gets.chomp
    puts 'Enter the train type number'
    Train::TRAIN_TYPE.each_with_index { |type, index| puts "#{index + 1} #{type}" }
    print ': '
    case gets.chomp
    when '1' then PassengerTrain.new(train_number)
    when '2' then CargoTrain.new(train_number)
    else
      raise 'Invalid train type!'
    end
    puts 'The train has been successfully created!'
  rescue RuntimeError => e
    puts "The train was not added. #{e.message}"
    retry
  end

  def create_route
    print 'Enter the route number: '
    route_number = gets.chomp
    print 'Enter the start station name: '
    start_station = find_station(gets.chomp)
    return if start_station.nil?

    print 'Enter the end station name: '
    end_station = find_station(gets.chomp)
    return if end_station.nil?

    Route.new(route_number, start_station, end_station)
    puts 'The route has been successfully created!'
  end

  def add_remove_intermediate_station(action)
    route = route_data_entry
    station = station_data_entry
    return if route.nil? || station.nil?

    station_on_route = find_station_on_route?(station, route)
    case action
    when 'add'
      if station_on_route
        puts 'The station is already on the route!'
      else
        route.add_intermediate_station(station)
        puts 'The station added to the route!'
      end
    when 'remove'
      if !station_on_route
        puts 'There is no such station on the route!'
      elsif route.stations.first == station || route.stations.last == station
        puts 'There is no such intermediate station on the route!'
      elsif !station.trains.empty?
        puts 'There are trains at the station!'
      else
        route.delete_intermediate_station(station)
        puts 'The station removed from the route!'
      end
    end
  end

  def assign_route
    route = route_data_entry
    train = train_data_entry
    return if route.nil? || train.nil?

    train.take_route(route)
    puts 'The route assigned to the train!'
  end

  def add_unhook_wagon(action)
    train = train_data_entry
    return if train.nil?

    print 'Enter the wagon number: '
    wagon_number = gets.chomp
    case action
    when 'add'
      case train.type
      when 'cargo'
        print 'Enter the total volume in cubic meters: '
        wagon = CargoWagon.new(wagon_number, gets.chomp.to_i)
      when 'passenger'
        print 'Enter the total number of seats: '
        wagon = PassengerWagon.new(wagon_number, gets.chomp.to_i)
      end
      train.attach_wagon(wagon)
      puts 'The wagon is attached to the train!'
    when 'unhook'
      wagon = train.wagons.select { |wagon_in| wagon_in.number == wagon_number }.last
      if wagon.nil?
        puts 'No wagon with this number found!'
      else
        train.unhook_wagon(wagon)
        puts 'The wagon is unhooked from the train!'
      end
    end
  end

  def view_wagons
    train = train_data_entry
    return if train.nil?

    puts 'Wagons:'
    train.each_wagon do |wagon|
      print "№:#{wagon.number} type:#{wagon.type} "
      puts "#{wagon.type == 'pass' ? 'seats' : 'volume'} free & occupied:8#{wagon.free} #{wagon.occupied}"
    end
  end

  def occupy_seat_volume
    train = train_data_entry
    return if train.nil?

    wagon = choose_wagon(train)
    case train.type
    when 'cargo'
      print 'Enter the loaded volume in cubic meters: '
      wagon.occupy(gets.chomp.to_i)
    when 'passenger'
      wagon.occupy
    end
  end

  def train_moving
    train = train_data_entry
    return if train.nil?

    print 'Enter the direction (forward or backward): '
    direction = gets.chomp
    case direction
    when 'forward' then result = train.moving_forward
    when 'backward' then result = train.moving_backward
    end
    puts  result.nil? ? 'The train DIDN\'T moved to the next station!' : 'The train moved to the next station!'
  end

  def view_stations
    route = route_data_entry
    return if route.nil?

    puts 'Stations:'
    route.show_stations
  end

  def view_trains
    station = station_data_entry
    return if station.nil?

    puts 'Trains:'
    station.each_train do |train|
      puts "№#{train.number} type:#{train.type} number of wagons:#{train.wagons.size}"
    end
  end

  # methods are only used inside an instance
  protected

  def find_train(number)
    train = Train.find(number)
    return train unless train.nil?

    puts 'There is NO train with this number'
  end

  def find_route(number)
    route = Route.find(number)
    return route unless route.nil?

    puts 'There is NO route with this number'
  end

  def find_station(name)
    station = Station.find(name)
    return station unless station.nil?

    puts 'There is NO station with this name'
  end

  def find_station_on_route?(station, route)
    route.stations.include?(station)
  end

  def choose_wagon(train)
    puts 'Wagons:'
    train.wagons.each_with_index { |wagon, index| puts "#{index + 1} - ##{wagon.number} #{wagon.total} #{wagon.free}" }
    begin
      print 'Enter the serial number of wagon (1,2,3,..): '
      number = gets.chomp.to_i
      raise "This's not the serial number of the wagon!" unless number.between?(1..train.wagons.size)
    rescue RuntimeError => e
      puts e.message
      retry
    end
    train.wagons[number - 1]
  end

  def train_data_entry
    print 'Enter the train number: '
    find_train(gets.chomp)
  end

  def route_data_entry
    print 'Enter the route number: '
    find_route(gets.chomp)
  end

  def station_data_entry
    print 'Enter the station name: '
    find_station(gets.chomp)
  end
end

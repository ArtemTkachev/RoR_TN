# frozen_string_literal: true

require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'

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
    print 'Enter the train type (passenger or cargo): '
    train_type = gets.chomp
    case train_type
    when 'passenger' then PassengerTrain.new(train_number)
    when 'cargo' then CargoTrain.new(train_number)
    end
    puts 'The train has been successfully created!'
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
    print 'Enter the route number: '
    route = find_route(gets.chomp)
    return if route.nil?

    print 'Enter the station name: '
    station = find_station(gets.chomp)
    return if station.nil?

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
    print 'Enter the train number: '
    train = find_train(gets.chomp)
    return if train.nil?

    print 'Enter the route number: '
    route = find_route(gets.chomp)
    return if route.nil?

    train.take_route(route)
    puts 'The route assigned to the train!'
  end

  def add_unhook_wagon(action)
    print 'Enter the train number: '
    train = find_train(gets.chomp)
    return if train.nil?

    print 'Enter the wagon number: '
    wagon_number = gets.chomp
    case action
    when 'add'
      train.attach_wagon(Wagon.new(wagon_number, train.type))
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

  def train_moving
    print 'Enter the train number: '
    train = find_train(gets.chomp)
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
    print 'Enter the route number: '
    route = find_route(gets.chomp)
    return if route.nil?

    puts 'Stations:'
    route.show_stations
  end

  def view_trains
    print 'Enter the station name: '
    station = find_station(gets.chomp)
    return if station.nil?

    puts 'Trains:'
    station.show_trains
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
end

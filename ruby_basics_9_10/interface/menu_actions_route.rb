# frozen_string_literal: true

require_relative '../models/route'
require_relative '../models/station'
require_relative 'menu_actions_assistant'

# module MenuActionsRoute
module MenuActionsRoute
  extend MenuActionsAssistant

  def create_route
    print 'Enter the route number: '
    route_number = gets.chomp
    print 'Need start station! '
    start_station = data_selection(:station)
    print 'Need end station! '
    end_station = data_selection(:station)
    Route.new(route_number, start_station, end_station)
    puts 'The route has been successfully created!'
  rescue RuntimeError => e
    puts e
    retry
  end

  def view_stations
    route = data_selection(:route)
    puts 'Stations:'
    route.show_stations
  end

  def add_intermediate_station
    station, route = station_route_enter
    raise 'The station is already on the route!' if route.stations.include?(station)

    route.add_intermediate_station(station)
    puts 'The station added to the route!'
  rescue RuntimeError => e
    puts e.message
  end

  def remove_intermediate_station
    station, route = station_route_enter
    remove_errors(route, station)
    route.delete_intermediate_station(station)
    puts 'The station removed from the route!'
  rescue RuntimeError => e
    puts e.message
  end

  protected

  def remove_errors(route, station)
    no_station_condition = route.stations.first == station || route.stations.last == station
    errors = []
    errors << 'There is no such station on the route!' unless route.stations.include?(station)
    errors << 'There is no such intermediate station on the route!' if no_station_condition
    errors << 'There are trains at the station!' unless station.trains.empty?
    raise errors.join('.') unless errors.empty?
  end

  def station_route_enter
    route = data_selection(:route)
    station = data_selection(:station)
    [station, route]
  end
end

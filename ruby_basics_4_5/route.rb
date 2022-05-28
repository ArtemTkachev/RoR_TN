# frozen_string_literal: true

require_relative 'instance_counter'

# class Route
class Route
  include InstanceCounter
  @@all_routes_created = []

  class << self
    def all
      @@all_routes_created
    end

    def find(route_number)
      @@all_routes_created.select { |route| route.number == route_number }.last
    end
  end

  attr_reader :number, :stations

  def initialize(number, start_station, end_station)
    @number = number
    @stations = []
    @stations << start_station
    @stations << end_station
    self.class.all << self
    register_instance
  end

  def add_intermediate_station(station)
    @stations.insert(stations.size - 1, station)
  end

  def delete_intermediate_station(station)
    @stations.delete(station) if station != stations.first && station != stations.last && station.trains.empty?
  end

  def show_stations
    stations.each { |station| puts station.name }
  end
end

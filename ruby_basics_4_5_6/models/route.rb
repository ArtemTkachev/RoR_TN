# frozen_string_literal: true

require_relative '../instance_counter'

# class Route
class Route
  include InstanceCounter
  @@routes = []

  ROUTE_NUMBER_FORMAT = /^\d{1,3}[A-Z]{1}$/.freeze

  class << self
    def all
      @@routes
    end

    def find(route_number)
      @@routes.select { |route| route.number == route_number }.last
    end
  end

  attr_reader :number, :stations

  def initialize(number, start_station, end_station)
    @number = number
    @stations = []
    @stations << start_station
    @stations << end_station
    validate!
    @@routes << self
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

  def validate!
    raise 'Invalid route number!' if number !~ ROUTE_NUMBER_FORMAT
    raise 'The start station is not set!' if @stations.first.nil?
    raise 'The end station is not set!' if @stations.last.nil?
  end
end

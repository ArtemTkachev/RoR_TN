# frozen_string_literal: true

require_relative '../lib/instances'
require_relative '../lib/validation'

# class Route
class Route
  include Instances
  include Validation

  ROUTE_NUMBER_FORMAT = /^\d{1,3}[A-Z]{1}$/.freeze

  attr_reader :number, :stations

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, ROUTE_NUMBER_FORMAT

  def initialize(number, start_station, end_station)
    @number = number
    @stations = []
    @stations << start_station
    @stations << end_station
    validate!
    validate_stations!
    add_instance
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

  def to_s
    number.to_s
  end

  protected

  def validate_stations!
    errors = []
    errors << 'The start station is not set!' if @stations.first.nil?
    errors << 'The end station is not set!' if @stations.last.nil?
    raise errors.join('.') unless errors.empty?
  end
end

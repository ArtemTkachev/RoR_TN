# frozen_string_literal: true

require_relative '../lib/manufacturing_company'
require_relative '../lib/instance_counter'

# class Train
class Train
  include ManufacturingCompany
  include InstanceCounter
  @@trains = []
  TRAIN_NUMBER_FORMAT = /^[0-9a-z]{3}-?[0-9a-z]{2}$/i.freeze
  TRAIN_TYPE = %w[passenger cargo].freeze

  class << self
    def all
      @@trains
    end

    def find(train_number)
      @@trains.select { |train| train.number == train_number }.last
    end
  end

  attr_reader :number, :type, :wagons

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    validate!
    @@trains << self
    register_instance
  end

  def unhook_wagon(wagon)
    @wagons.delete(wagon)
  end

  def attach_wagon(wagon)
    @wagons << wagon if wagon.type == @type
  end

  def take_route(route)
    @route = route
    @current_station = route.stations.first
    current_station.arrival_train(self)
  end

  def moving_forward
    return if next_station.nil?

    current_station.departure_train(self)
    next_station.arrival_train(self)
    @current_station = next_station
  end

  def moving_backward
    return if previous_station.nil?

    current_station.departure_train(self)
    previous_station.arrival_train(self)
    @current_station = previous_station
  end

  def each_wagon(&block)
    wagons.each { |wagon| block.call(wagon) } if block_given?
  end

  # methods are only used inside an instance
  protected

  attr_accessor :speed
  attr_reader :route

  def current_station
    @current_station unless route.nil?
  end

  def next_station
    return if route.nil? || route.stations.last == current_station

    route.stations[route.stations.index(current_station) + 1]
  end

  def previous_station
    return if route.nil? || route.stations.first == current_station

    route.stations[route.stations.index(current_station) - 1]
  end

  def validate!
    errors = []
    errors << 'Invalid train number!' if number !~ TRAIN_NUMBER_FORMAT
    errors << 'Invalid train type!' unless TRAIN_TYPE.include?(type)
    raise errors.join('.') unless errors.empty?
  end
end

# frozen_string_literal: true

require_relative 'manufacturing_company'
require_relative 'instance_counter'

# class Train
class Train
  include ManufacturingCompany
  include InstanceCounter
  @@all_trains_created = []

  class << self
    def all
      @@all_trains_created
    end

    def find(train_number)
      @@all_trains_created.select { |train| train.number == train_number }.last
    end
  end

  attr_reader :number, :type, :wagons

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    self.class.all << self
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
end

# frozen_string_literal: true

# class Train
class Train
  attr_reader :number, :type, :wagons

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
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

# frozen_string_literal: true

# class Train
class Train
  attr_reader :number, :type, :total_num_wagons
  attr_accessor :speed

  def initialize(number, type, total_num_wagons)
    @number = number
    @type = type
    @total_num_wagons = total_num_wagons
    @speed = 0
  end

  def attach_unhook_wagon(wagon_action)
    return unless @speed.zero?

    if wagon_action == 'attach'
      @total_num_wagons += 1
    elsif wagon_action == 'unhook' && @total_num_wagons >= 0
      @total_num_wagons -= 1
    end
  end

  def take_route(route)
    @route = route
    @current_station = route.stations.first
  end

  def moving(direction)
    return if @route.nil?

    if direction == 'forward' && @current_station != @route.stations.last
      @current_station = next_station
    elsif direction == 'back' && @current_station != @route.stations.first
      @current_station = previous_station
    end
  end

  def current_station
    @current_station unless @route.nil?
  end

  def next_station
    return if @route.nil? || @route.stations.last == @current_station

    @route.stations[@route.stations.index(@current_station) + 1]
  end

  def previous_station
    return if @route.nil? || @route.stations.first == @current_station

    @route.stations[@route.stations.index(@current_station) - 1]
  end
end

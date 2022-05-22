# frozen_string_literal: true

# class Route
class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = []
    @stations << start_station
    @stations << end_station
  end

  def add_intermed_station(station)
    @stations.insert(@stations.size - 1, station)
  end

  def delete_intermed_station(station)
    @stations.delete(station) if station != @stations.first && station != @stations.last && station.trains.empty?
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end
end

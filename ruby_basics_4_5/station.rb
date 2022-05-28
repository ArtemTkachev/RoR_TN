# frozen_string_literal: true

require_relative 'instance_counter'

# class Station
class Station
  include InstanceCounter
  @@all_stations_created = []

  class << self
    def all
      @@all_stations_created
    end

    def find(station_name)
      @@all_stations_created.select { |station| station.name == station_name }.last
    end
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    self.class.all << self
    register_instance
  end

  def arrival_train(train)
    @trains << train
  end

  def departure_train(train)
    @trains.delete(train)
  end

  def return_trains_by_type(type)
    trains.find_all { |train| train.type == type }
  end

  def show_trains
    trains.each { |train| puts "#{train.number}  #{train.type}" }
  end
end

# frozen_string_literal: true

require_relative '../lib/instances'

# class Station
class Station
  include Instances
  STATION_NAME_FORMAT = /^\w+\s?\w+$/.freeze

  class << self
    def find(station_name)
      instances.select { |station| station.name == station_name }.last
    end
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    validate!
    add_instance
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

  def each_train(&block)
    trains.each { |train| block.call(train) } if block_given?
  end

  def to_s
    name.to_s
  end

  protected

  def validate!
    raise 'Invalid station name!' if name !~ STATION_NAME_FORMAT
  end
end

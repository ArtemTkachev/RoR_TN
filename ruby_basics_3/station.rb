# frozen_string_literal: true

# class Station
class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrival_train(train)
    @trains << train
  end

  def departure_train(train)
    @trains.delete(train)
  end

  def return_trains_by_type(type)
    @trains.find_all { |train| train.type == type }
  end
end

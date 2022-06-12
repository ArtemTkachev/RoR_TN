# frozen_string_literal: true

require_relative '../models/route'
require_relative '../models/train'
require_relative '../models/passenger_train'
require_relative '../models/cargo_train'
require_relative 'menu_actions_assistant'

# module MenuActionsTrain
module MenuActionsTrain
  extend MenuActionsAssistant

  DIRECTIONS_METHODS = { forward: :moving_forward, backward: :moving_backward }.freeze
  TRAIN_CLASSES = { passenger: PassengerTrain, cargo: CargoTrain }.freeze

  def create_train
    print 'Enter the train number: '
    train_number = gets.chomp
    train_type = data_selection(:traintype, %i[passenger cargo])
    TRAIN_CLASSES[train_type].new(train_number)
    puts 'The train has been successfully created!'
  rescue RuntimeError => e
    puts e
    retry
  end

  def assign_route
    route = data_selection(:route)
    train = data_selection(:train)
    train.take_route(route)
    puts 'The route assigned to the train!'
  end

  def view_wagons
    train = data_selection(:train)
    puts 'Wagons:'
    train.each_wagon do |wagon|
      condition_type = (wagon.type == :passenger ? 'seats' : 'volume')
      puts "№:#{wagon.number} type:#{wagon.type} #{condition_type} free & occupied:#{wagon.free} #{wagon.occupied}"
    end
  end

  def train_moving
    train = data_selection(:train)
    direction = data_selection(:direction, %i[forward backward])
    result = train.send(DIRECTIONS_METHODS[direction])
    raise 'The train DIDN\'T moved to the next station!' if result.nil?

    puts 'The train moved to the next station!'
  end
end

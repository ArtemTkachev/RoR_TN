# frozen_string_literal: true

require_relative '../models/wagon'
require_relative '../models/train'
require_relative '../models/passenger_wagon'
require_relative '../models/cargo_wagon'
require_relative 'menu_actions_assistant'

# module MenuActionsWagon
module MenuActionsWagon
  extend MenuActionsAssistant

  TRAIN_CLASSES = { passenger: PassengerTrain, cargo: CargoTrain }.freeze

  def add_wagon
    train = data_selection(:train)
    print 'Enter the wagon number: '
    wagon_number = gets.chomp
    wagon = enter_total_quantity(train.type, wagon_number)
    train.attach_wagon(wagon)
    puts 'The wagon is attached to the train!'
  end

  def unhook_wagon
    train, wagon = train_wagon_enter
    train.unhook_wagon(wagon)
    puts 'The wagon is unhooked from the train!'
  end

  def occupy_seat_volume
    train, wagon = train_wagon_enter
    case train.type
    when :cargo
      print 'Enter the loaded volume in cubic meters: '
      wagon.occupy(gets.chomp.to_i)
    when :passenger
      wagon.occupy
    end
  end

  protected

  def enter_total_quantity(train_type, wagon_number)
    case train_type
    when :cargo
      print 'Enter the total volume in cubic meters: '
      CargoWagon.new(wagon_number, gets.chomp.to_i)
    when :passenger
      print 'Enter the total number of seats: '
      PassengerWagon.new(wagon_number, gets.chomp.to_i)
    end
  end

  def train_wagon_enter
    train = data_selection(:train)
    wagon = data_selection(:wagon, train.wagons)
    [train, wagon]
  end
end

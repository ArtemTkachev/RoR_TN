# frozen_string_literal: true

require_relative '../models/station'
require_relative '../models/route'
require_relative '../models/train'
require_relative '../models/passenger_train'
require_relative '../models/cargo_train'
require_relative '../models/wagon'
require_relative '../models/passenger_wagon'
require_relative '../models/cargo_wagon'

# module MenuActions
module MenuActionsAssistant
  protected

  TYPES = { station: [Station],
            route: [Route],
            train: [PassengerTrain, CargoTrain],
            wagon: [PassengerWagon, CargoWagon] }.freeze

  def data_selection(data_type, selection = :unknown)
    selection_in = self.selection(data_type, selection)
    data_output(data_type, selection_in)
    number = data_input(data_type, selection_in.size)
    selection_in[number - 1]
  end

  def selection(data_type, selection)
    return selection unless selection == :unknown

    selection_out = []
    TYPES[data_type].each do |select_type|
      selection_out.concat(select_type.instances)
    end
    selection_out
  end

  def data_output(data_type, selection)
    puts "Select #{data_type} (№ - #{data_type}):"
    selection.each_with_index { |instance, index| puts "#{index + 1} - #{instance}" }
  end

  def data_input(data_type, selection_size)
    print "Enter the serial number of #{data_type} (1,2,3,..): "
    number = gets.chomp.to_i
    raise "This's not the serial number!" unless number_valid(number, selection_size)

    number
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def number_valid(number, size)
    number.between?(1, size)
  end
end

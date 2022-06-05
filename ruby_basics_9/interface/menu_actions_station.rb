# frozen_string_literal: true

require_relative '../models/station'
require_relative '../models/train'
require_relative 'menu_actions_assistant'

# module MenuActionsStation
module MenuActionsStation
  extend MenuActionsAssistant

  def create_station
    print 'Enter the station name: '
    Station.new(gets.chomp)
    puts 'The station has been successfully created!'
  end

  def view_trains
    station = data_selection(:station)
    puts 'Trains:'
    station.each_train do |train|
      puts "№#{train.number} type:#{train.type} number of wagons:#{train.wagons.size}"
    end
  end
end

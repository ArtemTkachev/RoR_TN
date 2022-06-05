# frozen_string_literal: true

require_relative 'menu_actions_assistant'
require_relative 'menu_actions_station'
require_relative 'menu_actions_route'
require_relative 'menu_actions_train'
require_relative 'menu_actions_wagon'

# module Menu
module Menu
  extend MenuActionsAssistant
  extend MenuActionsStation
  extend MenuActionsRoute
  extend MenuActionsTrain
  extend MenuActionsWagon

  MENU_STR = "\nMenu:
      1 Create a station
      2 Create a train
      3 Create a route
      4 Add an itermediate station to a route
      5 Remove an intermediate station from a route
      6 Assign a route to a train
      7 Add a wagon to a train
      8 Unhook a wagon from a train
      9 Take a seat or volume in the wagon
      10 View a list of wagons at a train
      11 Move a train (forward or backward)
      12 View a list of stations on a route
      13 View a list of trains at a station
      14 Exit"
  MENU_ACTIONS_SELECT = %i[
    create_station
    create_train
    create_route
    add_intermediate_station
    remove_intermediate_station
    assign_route
    add_wagon
    unhook_wagon
    occupy_seat_volume
    view_wagons
    train_moving
    view_stations
    view_trains
  ].freeze

  def show_menu
    loop do
      puts MENU_STR
      print 'Enter the number of the menu item: '
      answer = gets.chomp.to_i
      break if MENU_ACTIONS_SELECT.size + 1 == answer

      send(MENU_ACTIONS_SELECT[answer - 1])
    end
  end
end

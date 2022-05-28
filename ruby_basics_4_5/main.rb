# frozen_string_literal: true

require_relative 'menu_actions'

menu_actions = MenuActions.new
loop do
  puts "\nMenu:
    1 Create a station
    2 Create a train
    3 Create a route
    4 Add an itermediate station to a route
    5 Remove an intermediate station from a route
    6 Assign a route to a train
    7 Add a wagon to a train
    8 Unhook a wagon from a train
    9 Move a train (forward or backward)
    10 View a list of stations on a route
    11 View a list of trains at a station
    12 Exit"
  print 'Enter the number of the menu item: '

  answer = gets.chomp.to_i
  case answer
  when 1 then menu_actions.create_station
  when 2 then menu_actions.create_train
  when 3 then menu_actions.create_route
  when 4 then menu_actions.add_remove_intermediate_station('add')
  when 5 then menu_actions.add_remove_intermediate_station('remove')
  when 6 then menu_actions.assign_route
  when 7 then menu_actions.add_unhook_wagon('add')
  when 8 then menu_actions.add_unhook_wagon('unhook')
  when 9 then menu_actions.train_moving
  when 10 then menu_actions.view_stations
  when 11 then menu_actions.view_trains
  when 12 then break
  end
end

# frozen_string_literal: true

Dir['./interface/*.rb'].sort!.each { |file| require_relative file }

# module Main
module Main
  extend MenuActionsAssistant
  extend MenuActionsStation
  extend MenuActionsRoute
  extend MenuActionsTrain
  extend MenuActionsWagon
  extend Menu

  show_menu
end

# frozen_string_literal: true

require_relative '../lib/wagon_filling'
require_relative 'wagon'

# class CargoWagon
class CargoWagon < Wagon
  include WagonFilling

  def initialize(number, total_volume)
    super(number, :cargo)
    @total = total_volume
    @occupied = 0
  end
end

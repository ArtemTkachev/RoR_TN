# frozen_string_literal: true

require_relative '../lib/wagon_filling'
require_relative 'wagon'

# class PassengerWagon
class PassengerWagon < Wagon
  include WagonFilling

  def initialize(number, total_seats)
    super(number, :passenger)
    @total = total_seats
    @occupied = 0
  end

  def occupy
    super(1)
  end
end

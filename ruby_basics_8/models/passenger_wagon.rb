# frozen_string_literal: true

require_relative '../lib/wagon_filling'

# class PassengerWagon
class PassengerWagon < Wagon
  include WagonFilling

  def initialize(number, total_seats)
    @total = total_seats
    @occupied = 0
    super(number, 'passenger')
  end

  def occupy
    super(1)
  end
end

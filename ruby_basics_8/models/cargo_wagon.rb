# frozen_string_literal: true

# class CargoWagon
class CargoWagon < Wagon
  include WagonFilling

  def initialize(number, total_volume)
    @total = total_volume
    @occupied = 0
    super(number, 'cargo')
  end
end

# frozen_string_literal: true

# class PassengerTrain
class PassengerTrain < Train
  def initialize(number)
    super(number, 'passenger')
  end
end

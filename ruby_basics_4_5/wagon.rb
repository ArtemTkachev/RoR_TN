# frozen_string_literal: true

require_relative 'manufacturing_company'

# class Wagon
class Wagon
  include ManufacturingCompany
  attr_reader :number, :type

  def initialize(number, type)
    @number = number
    @type = type
  end
end

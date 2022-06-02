# frozen_string_literal: true

require_relative '../lib/manufacturing_company'

# class Wagon
class Wagon
  include ManufacturingCompany
  attr_reader :number, :type

  WAGON_NUMBER_FORMAT = /^\d{6}[A-Z]{2}$/.freeze
  WAGON_TYPE = %w[passenger cargo].freeze

  def initialize(number, type)
    @number = number
    @type = type
    validate!
  end

  protected

  def validate!
    errors = []
    errors << 'Invalid wagon number!' if number !~ WAGON_NUMBER_FORMAT
    errors << 'Invalid wagon type!' unless WAGON_TYPE.include?(type)
    raise errors.join('.') unless errors.empty?
  end
end

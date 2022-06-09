# frozen_string_literal: true

require_relative '../lib/manufacturing_company'
require_relative '../lib/validation'

# class Wagon
class Wagon
  include ManufacturingCompany
  include Validation
  attr_reader :number, :type

  WAGON_NUMBER_FORMAT = /^\d{6}[A-Z]{2}$/.freeze
  WAGON_TYPE = %i[passenger cargo].freeze

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, WAGON_NUMBER_FORMAT

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    validate_type!
  end

  def to_s
    "#{number} #{type}"
  end

  protected

  def validate_type!
    errors = []
    errors << 'Invalid wagon type!' unless WAGON_TYPE.include?(type)
    raise errors.join('.') unless errors.empty?
  end
end

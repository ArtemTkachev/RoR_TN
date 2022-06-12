# frozen_string_literal: true

# module Validation
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # module ClassMethods
  module ClassMethods
    def validation_list
      @validation_list
      # instance_variable_get(:@validation_list)
    end

    def validate(attr_name, valid_type, parameter = nil)
      value = { attr_name: attr_name, valid_type: valid_type, parameter: parameter }
      (@validation_list ||= []) << value
      # instance_variable_set(:@validation_list, (instance_variable_get(:@validation_list) || []) << value)
    end
  end

  # module InstanceMethods
  module InstanceMethods
    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    protected

    def source
      source = self.class
      source = source.superclass until source.superclass == Object
      source
    end

    def validate!
      source.validation_list.each do |attr|
        validation(send(attr[:attr_name]), attr[:attr_name], attr[:valid_type], attr[:parameter])
      end
    end

    def validation(attr, name, type, parameter)
      raise "#{name} cannot be equal to nil or empry!" if type == :presence && (attr.nil? || attr == '')
      raise "#{name} does not match the format!" if type == :format && attr !~ parameter
      raise "#{name} does not match the specified class!" if type == :type && !attr.instance_of?(parameter)
    end
  end
end

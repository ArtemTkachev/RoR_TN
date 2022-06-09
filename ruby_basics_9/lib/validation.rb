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
      instance_variable_get(:@validation_list)
    end

    def validate(attr_name, valid_type, parameter = nil)
      value = { attr_name: attr_name, valid_type: valid_type, parameter: parameter }
      instance_variable_set(:@validation_list, (instance_variable_get(:@validation_list) || []) << value)
    end

    def inherited(subclass)
      subclass.instance_variable_set(:@validate_list, @validate_list)
      super
    end
  end

  # module InstanceMethods
  module InstanceMethods
    def valid?
      validate!
      true
    rescue RuntimeError => e
      false
    end

    protected

    def validate!
      self.class.validation_list.each do |attr|
        validation(send(attr[:attr_name]), attr[:attr_name], attr[:valid_type], attr[:parameter])
      end
    end

    def validation(attr, name, type, parameter)
      errors = []
      errors << "#{name} cannot be equal to nil or empry!" if type == :presence && (attr.nil? || attr == '')
      errors << "#{name} does not match the format!" if type == :format && attr !~ parameter
      errors << "#{name} does not match the specified class!" if type == :type && !attr.instance_of?(parameter)
      raise errors.join("\n") unless errors.empty?
    end
  end
end

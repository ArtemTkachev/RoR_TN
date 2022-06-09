# frozen_string_literal: true

# module Accessors
module Accessors
  def attr_accessor_with_history(*attr_names)
    attr_names.each do |name|
      variable_name = "@#{name}".to_sym
      # variable_name_history = "@#{name}_history".to_sym
      define_method(name) { (instance_variable_get(variable_name) || []).last }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(variable_name, (instance_variable_get(variable_name) || []) << value)
        # instance_variable_set(variable_name_history, (instance_variable_get(variable_name_history) || []) << value)
      end
      define_method("#{name}_history".to_sym) { instance_variable_get(variable_name) }
    end
  end

  def strong_attr_accessor(attr_name, attr_class)
    variable_name = "@#{attr_name}".to_sym
    define_method(attr_name) { instance_variable_get(variable_name) }
    define_method("#{attr_name}=".to_sym) do |value|
      raise 'The attribute type does not match!' unless value.instance_of?(attr_class)

      instance_variable_set(variable_name, value)
    end
  end
end

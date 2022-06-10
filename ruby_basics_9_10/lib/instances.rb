# frozen_string_literal: true

# module InstanceCounter
module Instances
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # module ClassMethods
  module ClassMethods
    def instances_counter
      @instances_counter ||= 0
    end

    def instances
      @instances ||= []
    end

    def instance_counter_add
      @instances_counter ||= 0
      @instances_counter += 1
    end

    def find(number)
      instances.select { |instance| instance.number == number }.last
    end
  end

  # module InstanceMethods
  module InstanceMethods
    protected

    def add_instance
      self.class.instances << self
    end

    def register_instance
      self.class.instance_counter_add
    end
  end
end

# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.class_variable_set(:@@instance_counter, 0)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      class_variable_get(:@@instance_counter)
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.class_variable_set(:@@instance_counter, self.class.class_variable_get(:@@instance_counter) + 1)
    end
  end
end

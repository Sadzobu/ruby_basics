# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attr_names)
      attr_names.each do |name|
        var_name = "@#{name}".to_sym
        var_history_name = "@#{name}_history".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}_history".to_sym) { instance_variable_get(var_history_name) || [nil] }
        define_method("#{name}=".to_sym) do |value|
          current_value = instance_variable_get(var_history_name) || [nil]
          instance_variable_set(var_name, value)
          instance_variable_set(var_history_name, current_value << value)
        end
      end
    end

    def strong_attr_accessor(attr_name, attr_class)
      var_name = "@#{attr_name}".to_sym
      define_method(attr_name) { instance_variable_get(var_name) }
      define_method("#{attr_name}=") do |value|
        raise TypeError.new, "wrong value class, expected #{attr_class}" unless value.instance_of?(attr_class)

        instance_variable_set(var_name, value)
      end
    end
  end
end

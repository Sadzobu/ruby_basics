# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(attr_name, validation_type, attr_options = '')
      self.validations ||= []
      validations << ([attr_name, validation_type, attr_options])
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        send(validation[1], instance_variable_get("@#{validation[0]}".to_sym), validation[2])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end

  private

  def presence(attr_name, _attr_options)
    raise "#{attr_name} cannot be blank" if attr_name.nil? || attr_name.to_s.empty?
  end

  def format(attr_name, attr_options)
    raise "#{attr_name} should match the specified format #{attr_options}" if attr_name !~ attr_options
  end

  def type(attr_name, attr_options)
    raise "#{attr_name} should be of type #{attr_options}" unless attr_name.instance_of?(attr_options)
  end
end

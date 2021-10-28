module Validation
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    def valid?
      self.validate!
      true
    rescue
      false
    end
  end
end
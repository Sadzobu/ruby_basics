# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate; end
  end

  module InstanceMethods
    def validate!; end

    def valid?; end
  end
end

# frozen_string_literal: true

module PassBlock
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    def pass_block(object, &block)
      object.each(&block)
    end
  end
end

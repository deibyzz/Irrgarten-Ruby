#encoding:utf-8
require_relative 'Dice'
module Irrgarten
  class CombatElement
    def initialize(effect,uses)
      @effect = effect
      @uses = uses
    end

    private_class_method :new

    protected def produce_effect()
      effect = 0
      if(@uses > 0)
        effect = @effect
        @uses -= 1
      end
      effect
    end

    def to_s
      return ("[#{@effect},#{@uses}]")
    end

    def discard
      Dice.discard_element(@uses)
    end
  end
end
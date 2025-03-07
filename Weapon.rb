#encoding:utf-8
require_relative 'Dice'
module Irrgarten
  class Weapon
    def initialize(p,u)
      @power = p
      @uses = u
    end
  
    public
    def attack()
      ap = 0
      if(uses > 0)
        ap = power
        uses -= 1
      end
      return ap
    end
  
    def to_s()
      return ("W["+@power.to_s+","+@uses.to_s+"]")
    end

    def discard()
      Dice.discard_element(@uses)
    end
  end
end
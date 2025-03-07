#encoding:utf-8
module Irrgarten
  class Weapon
    def Initialize(p,u)
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
      return ("W["+power+","+uses+"]")
    end
  end
end
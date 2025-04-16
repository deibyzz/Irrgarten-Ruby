#encoding:utf-8
require_relative 'Dice'
module Irrgarten
  class Shield
    def initialize(p,u)
      @protection = p
      @uses = u
    end
  
    public
    def protect()
      dp = 0
      if(@uses > 0)
        dp = @protection
        @uses -= 1
      end
      return dp
    end
  
    def to_s()
      return ("S["+@protection.to_s+","+@uses.to_s+"]")
    end

    def discard()
      Dice.discard_element(@uses)
    end
  end
end
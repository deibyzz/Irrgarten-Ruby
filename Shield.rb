#encoding:utf-8
module Irrgarten
  class Shield
    def Initialize(p,u)
      @protection = p
      @uses = u
    end
  
    public
    def protect()
      dp = 0
      if(uses > 0)
        dp = protection
        uses -= 1
      end
      return dp
    end
  
    def to_s()
      return ("W["+protection+","+uses+"]")
    end
  end
end
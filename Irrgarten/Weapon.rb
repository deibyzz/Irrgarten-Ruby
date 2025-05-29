#encoding:utf-8
require_relative 'CombatElement'
module Irrgarten
  class Weapon < CombatElement
    def initialize(p,u)
      super(p,u)
    end

    public_class_method :new
  
    def attack()
      return produce_effect()
    end
  
    def to_s()
      return ("W" + super())
    end
  end
end
#encoding:utf-8
require_relative 'Dice'
require_relative 'LabyrinthCharacter'
module Irrgarten
  class Monster < LabyrinthCharacter
    @@INITIAL_HEALTH=5
    def initialize(name,intelligence,strength)
      super(name,intelligence,strength,@@INITIAL_HEALTH)
    end

    public_class_method :new

    def attack
      Dice.intensity(@strength)
    end

    def defend(recieved_attack)
      if(!dead())
        if(Dice.intensity(@intelligence) < recieved_attack)
          got_wounded()
        end
      end

      dead()
    end

    def to_s
      return ("Monster:" + super)
    end
  end
end
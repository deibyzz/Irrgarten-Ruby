#encoding:utf-8
module Irrgarten
  class Dice
      @@MAX_USES=5
      @@MAX_INTELLIGENCE=10.0
      @@MAX_STRENGTH=10.0
      @@RESURRECT_PROB=0.3
      @@WEAPONS_REWARD=2
      @@SHIELDS_REWARD=3
      @@HEALTH_REWARD=5
      @@MAX_ATTACK=3.0
      @@MAX_SHIELD=2.0
      @@generator = Random.new

    def self.random_pos(max)
      @@generator.rand(max)
    end

    def self.who_starts(nplayers)
      @@generator.rand(nplayers)
    end

    def self.random_intelligence()
      @@generator.rand(@@MAX_INTELLIGENCE)
    end

    def self.random_strength()
      @@generator.rand(@@MAX_STRENGTH)
    end

    def self.resurrect_player()
      resurrect = false
      if(@@generator.rand() < @@RESURRECT_PROB)
        resurrect = true
      end
      resurrect
    end

    def self.weapons_reward()
      @@generator.rand(@@WEAPONS_REWARD+1)
    end

    def self.shields_reward()
      @@generator.rand(@@SHIELDS_REWARD+1)
    end

    def self.health_reward()
      @@generator.rand(@@HEALTH_REWARD+1)
    end

    def self.weapon_power()
      @@generator.rand(@@MAX_ATTACK)
    end

    def self.shield_power()
      @@generator.rand(@@MAX_SHIELD)
    end

    def self.uses_left()
      @@generator.rand(@@MAX_USES)
    end

    def self.intensity(competence)
      @@generator.rand(competence)
    end

    def self.discard_element(usesLeft)
      discard = false
      conditioning = usesLeft.fdiv(@@MAX_USES)
      if(@@generator.rand()>=conditioning)
        discard=true
      end
      discard
    end
  end
end
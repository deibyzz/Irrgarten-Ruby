#encoding:utf-8
module Irrgarten
  class Dice
    def Initialize()
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
    end

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
      if(@@generator.rand() < @@RESURRECT_PROB){
        resurrect = true
      }
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

    def self.
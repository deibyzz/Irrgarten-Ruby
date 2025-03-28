#encoding:utf-8
require_relative 'Dice'
module Irrgarten
  class Monster
    @@INITIAL_HEALTH=5
    @@NULL_POS=-1
    def initialize(name,intelligence,strength)
      @name=name
      @intelligence=intelligence
      @strength=strength
      @health=@@INITIAL_HEALTH
      @row = @col = @@NULL_POS
    end
    def dead
      @health <= 0
    end
    def attack
      Dice.intensity(@strength)
    end
    def defend(recieved_attack)

    end
    def set_pos(row,col)
      @row = row
      @col = col
    end
    def to_s
      "Monster: #{@name} I: #{@intelligence} S: #{@strength} HP: #{@health} Pos: (#{@row},#{@col})"
    end

    private
    def got_wounded
      @health -= 1
    end
  end
end
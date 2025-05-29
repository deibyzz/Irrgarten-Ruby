#encoding:utf-8
require_relative 'Player'
module Irrgarten
  class FuzzyPlayer < Player
    def initialize(other)
      copy(other)
      @consecutive_hits = 0
    end

    def move(direction, valid_moves)
      normal_move = super(direction,valid_moves)
      return Dice.next_step(direction,valid_moves,@intelligence)
    end

    def attack()
      return (sum_weapons() + Dice.intensity(@strength))
    end

    protected def defensive_energy()
      return (sum_shields() + Dice.intensity(@intelligence))
    end

    def to_s
      return ("Fuzzy"+super)
    end
  end
end
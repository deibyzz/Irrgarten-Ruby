#encoding:utf-8
require_relative 'Weapon'
require_relative 'Shield'
require_relative 'Dice'
module Irrgarten
  class Player
    @@MAX_WEAPONS=2
    @@MAX_SHIELDS=3
    @@INITIAL_HEALTH=5
    @@HITS2LOSE=3
    @@NULL_POS=-1

    def initialize(number,intelligence,strength)
      @name="Player #{number}"
      @number = "#{number}"
      @intelligence=intelligence
      @strength=strength
      @health=@INITIAL_HEALTH
      @row=@col=-1
      @weapons = Array.new(@@MAX_WEAPONS)
      @shields = Array.new(@@MAX_SHIELD)
      @consecutive_hits=0
    end

    def resurrect
      @weapons.clear
      @shields.clear
      @health = @@INITIAL_HEALTH
    end

    attr_reader :row
    attr_reader :col
    attr_reader :number

    def set_pos(row,col)
      @row = row
      @col = col
    end

    def dead
      health <= 0
    end

    def move(direction,valid_moves)

    end

    def attack
      @strength + self.sum_weapons
    end

    def defend(recieved_attack)

    end

    def recieve_reward

    end

    def to_s
      string = "#{@name} I: #{@intelligence} S:#{@strength} HP:#{@health} Pos: (#{@row},#{@col}) {"
      for i in 0..@weapons.size()-1 do
        string += @weapons[i].to_s + ','
      end

      string += @weapons.last.to_s + "} {"

      for i in 0..@shields.size()-1 do
        string += @shields[i].to_s + ','
      end 

      string += @weapons.last.to_s + '}'
    end

    private
    def recieve_weapon(weapon)

    end

    private
    def recieve_shield(shield)
      
    end

    private
    def new_weapon
      Weapon.new(Dice.weapon_power,Dice.uses_left)
    end

    private
    def new_weapon
      Shield.new(Dice.shield_power,Dice.uses_left)
    end

    private
    def sum_weapons
      sum = 0
      for weapon in @weapons do
        sum += weapon.attack
      end
      sum
    end

    private
    def sum_shields
      sum = 0
      for shield in @shields do
        sum += shield.defend
      end
      sum
    end

    private
    def defensive_energy
      intelligence + self.sum_shields
    end

    private
    def manage_hit(recieved_attack)

    end

    private
    def reset_hits
      @consecutive_hits=0
    end

    private
    def got_wounded
      @health -= 1
    end

    private
    def inc_consecutive_hits
      @consecutive_hits += 1
    end

  end
end
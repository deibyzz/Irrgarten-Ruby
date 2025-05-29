#encoding:utf-8
require_relative 'Weapon'
require_relative 'Shield'
require_relative 'Dice'
require_relative 'LabyrinthCharacter'
module Irrgarten
  class Player < LabyrinthCharacter
    @@MAX_WEAPONS=2
    @@MAX_SHIELDS=3
    @@HITS2LOSE=3
    @@INITIAL_HEALTH = 10

    def initialize(number,intelligence,strength)
      super("Player #{number}",intelligence,strength, @@INITIAL_HEALTH)
      @number = number
      @consecutive_hits = 0
      @weapons = Array.new
      @shields = Array.new
      #Añadir WeaponCardDeck y ShieldCardDeck
    end

    public_class_method :new

    def copy(other)
      super(other)
      @number = other.number
      @weapons = other.weapons
      @shields = other.shields
    end

    def resurrect
      @weapons.clear
      @shields.clear
      @health = @@INITIAL_HEALTH
      reset_hits()
    end

    attr_reader :number, :weapons, :shields

    def move(direction,valid_moves)
      contained = valid_moves.include?(direction)
      move_dir = direction
      if(!(valid_moves.empty? || contained))
        move_dir = valid_moves[0]
      end
      move_dir
    end

    def attack
      @strength + self.sum_weapons
    end

    def defend(recieved_attack)
      manage_hit(recieved_attack)
    end

    def recieve_reward
      wreward = Dice.weapons_reward()
      sreward = Dice.shields_reward()
      puts "Número de armas: #{wreward}; Número de escudos: #{sreward}"
      for i in 0...wreward
        weapon = new_weapon()
        recieve_weapon(weapon)
      end

      for i in 0...sreward
        shield = new_shield()
        recieve_shield(shield)
      end

      @health += Dice.health_reward()
    end

    def to_s
      string = super
      for i in 0...@weapons.size()-1 do
        string += @weapons[i].to_s + ','
      end

      string += @weapons.last.to_s + "} {"

      for i in 0...@shields.size()-1 do
        string += @shields[i].to_s + ','
      end 

      string += @shields.last.to_s + '}'
    end

    private
    def recieve_weapon(weapon)
      for w in @weapons
        if(w.discard())
          @weapons.delete(w)
        end
      end

      if(@weapons.size() < @@MAX_WEAPONS)
        @weapons.push(weapon)
      end
    end

    private
    def recieve_shield(shield)
      for s in @shields
        if(s.discard())
          @shields.delete(s)
        end
      end

      if(@shields.size() < @@MAX_SHIELDS)
        @shields.push(shield)
      end
    end

    private
    def new_weapon
      Weapon.new(Dice.weapon_power,Dice.uses_left)
    end

    private
    def new_shield
      Shield.new(Dice.shield_power,Dice.uses_left)
    end

    private
    protected def sum_weapons
      sum = 0
      if(!@weapons.empty?)
        for weapon in @weapons do
          sum += weapon.attack
        end
      end
      sum
    end

    private
    protected def sum_shields
      sum = 0
      if(!@shields.empty?)
        for shield in @shields do
          sum += shield.protect
        end
      end
      sum
    end

    private
    protected def defensive_energy
      @intelligence + self.sum_shields
    end

    private
    def manage_hit(recieved_attack)
      defense = defensive_energy()
      lose = nil
      if(defense < recieved_attack)
        got_wounded()
        inc_consecutive_hits()
      else
        reset_hits()
      end

      if(@consecutive_hits == @@HITS2LOSE || dead())
        reset_hits()
        lose = true
      else
        lose = false
      end
      lose
    end

    private
    def reset_hits
      @consecutive_hits=0
    end

    private
    def inc_consecutive_hits
      @consecutive_hits += 1
    end
  end
end
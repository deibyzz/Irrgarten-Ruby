#encoding:utf-8
module Irrgarten
  class LabyrinthCharacter
    @@NULL_POS = -1
    def initialize(name,intelligence,strength,health)
      @name = name
      @intelligence = intelligence
      @strength = strength
      @health = health
      @row = @@NULL_POS
      @col = @@NULL_POS
    end

    def copy(other)
      @name = other.name
      @intelligence = other.intelligence
      @strength = other.strength
      @health = other.health
      set_pos(other.row,other.col)
    end

    def dead
      return (@health <= 0)
    end

    private_class_method :new
    attr_reader :name, :row, :col
    protected attr_reader :intelligence, :strength
    protected attr_accessor :health

    def set_pos(row,col)
      @row = row
      @col = col
    end

    def to_s
      return ("#{@name} I:#{@intelligence} S:#{@strength} HP:#{@health} Pos: {#{@row},#{@col}}")
    end

    protected def got_wounded
      @health -= 1
    end

    def attack
    end

    def defend(recieved_attack)
    end
  end
end
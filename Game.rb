#encoding_utf-8
require_relative 'Monster'
require_relative 'Player'
require_relative 'Dice'
require_relative 'GameState'
require_relative 'Labyrinth'
module Irrgarten
  class Game
    @@MAX_ROUNDS = 10

    def initialize(nplayers)
      @players = Array.new(nplayers)
      @monsters = Array.new
      for i in [0...nplayers]
        @players.push(Player.new(i,Dice.random_intelligence,Dice.random_strength))
      end
      @current_player_index = Dice.who_starts(nplayers)
      @current_player = @players[@current_player_index]
      @log = ""
      configure_labyrinth()
      @labyrinth.spread_players(@players)
    end

    def finished
      @labyrinth.have_a_winner
    end

    def next_step(preferred_direction)

    end

    def getGameState
      player_str = "Players:\n",monster_str="Monsters:\n"
      for player in @players
        player_str += player.to_s + "\n"
      end
      for monster in @monsters
        monster_str = monster.to_s + "\n"
      end

      GameState.new(@labyrinth.to_s,player_str,monster_str,@current_player_index,self.finished,@log)
    end

    private
    def configure_labyrinth
        @labyrinth = Labyrinth.new(10,10,5,9)
        @labyrinth.add_block(Orientation::HORIZONTAL,0,0,10);
        @labyrinth.add_block(Orientation::HORIZONTAL,9,0,10);
        @labyrinth.add_monster(3,3,Monster.new("Dongo",Dice.random_intelligence,Dice.random_strength))

        puts @labyrinth.to_s

    end

    private
    def next_player
      @current_player_index = (@current_player_index+1) % @players.size 
      @current_player = @players[@current_player_index]
    end

    private
    def actual_direction(preferred_direction)

    end

    private
    def combat(monster)
    end

    private
    def manage_reward(winner)

    end

    private
    def manage_resurrection
    end

    private
    def log_player_won
      @log += "El jugador " + @currentPlayerIndex + " ha ganado el combate!!\n"
    end

    private
    def log_monster_won
      @log += "El monstruo ha ganado el combate...\n"
    end
    private
    def log_resurrected
      @log += "El jugador " + @currentPlayerIndex + " ha sido resucitado!!\n"
    end

    private
    def log_player_skip_turn
      @log += "El jugador " + @currentPlayerIndex + " sigue tieso...\n"
    end

    private
    def log_player_no_orders
      @log += "El jugador " + @currentPlayerIndex + " no siguió las ordenes del jugador humano\n"
    end

    private
    def log_no_monster
      @log += "El jugador " + @currentPlayerIndex + " no se ha cruzado a un monstruo en su movimiento\n"
    end

    private
    def log_rounds(rounds,max)
      @log += "Se han jugado " + rounds +" de " + max +" rondas\n";
    end
  end
end
#encoding_utf-8
require_relative 'Monster'
require_relative 'Player'
require_relative 'Dice'
require_relative 'GameCharacter'
require_relative 'GameState'
require_relative 'Labyrinth'
module Irrgarten
  class Game
    @@MAX_ROUNDS = 10

    def initialize(nplayers)
      @players = Array.new
      @monsters = Array.new
      for i in 0...nplayers
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
      @log = ""
      if(!@current_player.dead())
        direction = actual_direction(preferred_direction)
        if(direction != preferred_direction)
          log_player_no_orders()
        end

        monster = @labyrinth.put_player(direction,@current_player)

        if(monster == nil)
          log_no_monster()
        else
          manage_reward(combat(monster))
        end
      else
        manage_resurrection()
      end

      if(!finished())
        next_player()
      end

      finished()
    end

    def game_state
      player_str = "Players:\n"
      monster_str="Monsters:\n"
      for player in @players
        player_str << player.to_s << "\n"
      end
      for monster in @monsters
        monster_str << monster.to_s << "\n"
      end

      GameState.new(@labyrinth.to_s,player_str,monster_str,@current_player_index,self.finished,@log)
    end

    private
    def configure_labyrinth
      @labyrinth = Labyrinth.new(10,10,5,9)
      @labyrinth.add_block(Orientation::HORIZONTAL, 0,0, 10)
      @labyrinth.add_block(Orientation::HORIZONTAL, 9,0, 10)
      @labyrinth.add_block(Orientation::HORIZONTAL, 1,5, 1)
      @labyrinth.add_block(Orientation::HORIZONTAL, 1,7, 2)
      @labyrinth.add_block(Orientation::HORIZONTAL, 2,1, 3)
      @labyrinth.add_block(Orientation::HORIZONTAL, 3,5, 1)
      @labyrinth.add_block(Orientation::HORIZONTAL, 3,7, 2)
      @labyrinth.add_block(Orientation::VERTICAL, 4,1, 2)
      @labyrinth.add_block(Orientation::VERTICAL, 4,3, 2)
      @labyrinth.add_block(Orientation::VERTICAL, 4,5, 1)
      @labyrinth.add_block(Orientation::VERTICAL, 4,7, 2)
      @labyrinth.add_block(Orientation::HORIZONTAL, 6,4, 2)
      @labyrinth.add_block(Orientation::VERTICAL, 7,0, 1)
      @labyrinth.add_block(Orientation::VERTICAL, 7,2, 1)
      @labyrinth.add_block(Orientation::VERTICAL, 7,5, 1)
      @labyrinth.add_block(Orientation::VERTICAL, 8,7, 1)
      
      monster = Monster.new("Glorbo Fruttodrilo",10,8.5)
      @monsters.push(monster)
      @labyrinth.add_monster(2, 9, monster)
      monster = Monster.new("Tung tung tung tung tung tung tung tung tung tung tung Sahur",6.75,10)
      @monsters.push(monster)
      @labyrinth.add_monster(5, 5, monster)
      monster = Monster.new("Brr Brr Patapim",9.2,9.5)
      @monsters.push(monster)
      @labyrinth.add_monster(6, 7, monster)
      monster = Monster.new("Brii Brii Bicus Dicus de Bicus de Dicus",5.5,9)
      @monsters.push(monster)
      @labyrinth.add_monster(7, 7, monster)
      
      for i in 0...3
          monster = Monster.new("Random creature",Dice.random_intelligence(),Dice.random_strength())
          @monsters.push(monster)
          @labyrinth.add_monster(Dice.random_pos(10), Dice.random_pos(10), monster)
      end

    end

    private
    def next_player
      @current_player_index = (@current_player_index+1) % @players.size 
      @current_player = @players[@current_player_index]
    end

    private
    def actual_direction(preferred_direction)
      moves = @labyrinth.valid_moves(@current_player.row,@current_player.col)
      @current_player.move(preferred_direction,moves)
    end

    private
    def combat(monster)
      rounds = 0
      winner = GameCharacter::PLAYER
      lose = monster.defend(@current_player.attack())
      while(!lose && rounds < @@MAX_ROUNDS)
        winner = GameCharacter::MONSTER
        rounds += 1
        lose = @current_player.defend(monster.attack())
        if(!lose)
          winner = GameCharacter::PLAYER
          lose = monster.defend(@current_player.attack())
        end
      end

      log_rounds(rounds,@@MAX_ROUNDS)
      winner
    end

    private
    def manage_reward(winner)
      if(winner == GameCharacter::PLAYER)
        @current_player.recieve_reward()
        log_player_won()
      else
        log_monster_won()
      end
    end

    private
    def manage_resurrection
      if(Dice.resurrect_player())
        @current_player.resurrect()
        log_resurrected()
      else
        log_player_skip_turn()
      end
    end

    private
    def log_player_won
      @log += "El jugador #{@current_player_index} ha ganado el combate!!\n"
    end

    private
    def log_monster_won
      @log += "El monstruo ha ganado el combate...\n"
    end
    private
    def log_resurrected
      @log += "El jugador #{@current_player_index} ha sido resucitado!!\n"
    end

    private
    def log_player_skip_turn
      @log += "El jugador #{@current_player_index} sigue tieso...\n"
    end

    private
    def log_player_no_orders
      @log += "El jugador #{@current_player_index} no siguió las ordenes del jugador humano\n"
    end

    private
    def log_no_monster
      @log += "El jugador #{@current_player_index} no se ha cruzado a un monstruo en su movimiento\n"
    end

    private
    def log_rounds(rounds,max)
      @log += "Se han jugado #{rounds} de #{max} rondas\n"
    end
  end
end
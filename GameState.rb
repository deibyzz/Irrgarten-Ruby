#encoding:utf-8
module Irrgarten
  class GameState
    def initialize(labyrinth,players,monsters,currentPlayer,winner,log)
      @labyrinth=labyrinth
      @players=players
      @monsters=monsters
      @currentPlayer=currentPlayer
      @winner=winner
      @log=log
    end

    def get_labyrinth
      @labyrinth
    end

    def get_players
      @players
    end

    def get_monsters
      @monsters
    end

    def get_current_player
      @currentPlayer
    end

    def get_winner
      @winner
    end

    def get_log
      @log
    end
  end
end
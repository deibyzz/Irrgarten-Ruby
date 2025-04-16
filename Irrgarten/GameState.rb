#encoding:utf-8
module Irrgarten
  class GameState
    def initialize(labyrinth,players,monsters,currentPlayer,winner,log)
      @labyrinth=labyrinth
      @players=players
      @monsters=monsters
      @current_player=currentPlayer
      @winner=winner
      @log=log
    end
    attr_reader :labyrinth

    attr_reader :players

    attr_reader :monsters

    attr_reader :current_player

    attr_reader :winner

    attr_reader :log
  end
end
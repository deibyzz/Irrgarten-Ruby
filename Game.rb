#encoding_utf-8
require_relative 'Monster'
require_relative 'Player'
require_relative 'Dice'
module Irrgarten
  class Game
    @@MAX_ROUNDS = 10

    def initialize(nplayers)
      @players = Array.new(nplayers)
      for i in [0...nplayers]
        @players.push(Player.new(i,Dice.random_intelligence,Dice.random_strength))
      end
      @current_player_index = Dice.who_starts(nplayers)
      @current_player = @players[@current_player_index]
      @log = ""
      @labyrinth = Labyrinth.new
      configure_labyrinth()
      labyrinth.spread_players(@players)
    end
  end
end
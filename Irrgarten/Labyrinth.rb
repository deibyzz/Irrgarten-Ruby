#encoding:utf-8
require_relative 'Monster'
require_relative 'Player'
require_relative 'Dice'
require_relative 'Orientation'
module Irrgarten
  class Labyrinth
    @@BLOCK_CHAR = 'X'
    @@EMPTY_CHAR = '-'
    @@MONSTER_CHAR = 'M'
    @@COMBAT_CHAR = 'C'
    @@EXIT_CHAR = 'E'
    @@ROW=0
    @@COL=1

    def initialize(nrows,ncols,exitrow,exitcol)
      @nrows=nrows
      @ncols=ncols
      @exitrow=exitrow
      @exitcol=exitcol
      @players = Array.new(nrows) {Array.new(ncols)}
      @monsters = Array.new(nrows) {Array.new(ncols)}
      @squares = Array.new(nrows) {Array.new(ncols) {@@EMPTY_CHAR}}
      @squares[exitrow][exitcol] = @@EXIT_CHAR;
    end

    def spread_players(player_list)
      for player in player_list
        pos = random_empty_pos()
        put_player2D(-1,-1,pos[@@ROW],pos[@@COL],player) #Magic numbers??
      end
    end

    def have_a_winner
      @players[@exitrow][@exitcol] != nil
    end

    def to_s
      map = ""
      for row in 0...@nrows
        for col in 0...@ncols
          map += @squares[row][col] + ' '
        end
        map += "\n"
      end
      map
    end

    def add_monster(row,col,monster)
      if(pos_ok(row,col))
        if(empty_pos(row,col))
          @monsters[row][col] = monster
          @squares[row][col] = @@MONSTER_CHAR
          monster.set_pos(row,col)
        end
      end
    end

    def put_player(direction, player)
      oldrow = player.row
      oldcol = player.col
      newpos = dir2pos(oldrow,oldcol,direction)
      put_player2D(oldrow,oldcol,newpos[@@ROW],newpos[@@COL],player)
    end

    def add_block(orientation,startrow,startcol,length)
        incRow = 0
        incCol = 0
        row = startrow
        col = startcol
        if(orientation == Orientation::VERTICAL)
          incRow = 1
        else
          incCol = 1
        end

        while(pos_ok(row,col) && empty_pos(row,col) && length > 0)
          @squares[row][col] = @@BLOCK_CHAR
          row += incRow
          col += incCol
          length -= 1
        end
    end

    def valid_moves(row,col)
      moves = Array.new
      if(can_step_on(row+1,col))
        moves.push(Directions::DOWN)
      end
      if(can_step_on(row-1,col))
        moves.push(Directions::UP)
      end
      if(can_step_on(row,col+1))
        moves.push(Directions::RIGHT)
      end
      if(can_step_on(row,col-1))
        moves.push(Directions::LEFT)
      end
      moves
    end

    private
    def pos_ok(row,col)
      ((0<=row) && (row < @nrows) && (0<=col) && (col < @ncols))
    end

    private
    def empty_pos(row,col)
      if(pos_ok(row,col))
        @squares[row][col] == @@EMPTY_CHAR
      end
    end

    private
    def monster_pos(row,col)
      if(pos_ok(row,col))
        @squares[row][col] == @@MONSTER_CHAR
      end
    end

    private
    def exit_pos(row,col)
      if(pos_ok(row,col))
        @squares[row][col] == @@EXIT_CHAR
      end
    end

    private
    def combat_pos(row,col)
      if(pos_ok(row,col))
        @squares[row][col] == @@COMBAT_CHAR
      end
    end

    private
    def can_step_on(row,col)
      (pos_ok(row,col)&&(empty_pos(row,col)||monster_pos(row,col)||exit_pos(row,col)))
    end

    private
    def update_old_pos(row,col)
      if(pos_ok(row,col))
        if(combat_pos(row,col))
          @squares[row][col] = @@MONSTER_CHAR
        else
          @squares[row][col] = @@EMPTY_CHAR
        end
      end
    end

    private
    def dir2pos(row,col,direction)
      pos = [row,col]
      case direction
      when Directions::DOWN
        pos[@@ROW] += 1
      when Directions::UP
        pos[@@ROW] -= 1
      when Directions::LEFT
        pos[@@COL] -= 1
      when Directions::RIGHT
        pos[@@COL] += 1
      end

      pos
    end

    private
    def random_empty_pos
      pos = Array.new(2)
      row = Dice.random_pos(@nrows)
      col = Dice.random_pos(@ncols)
      while(!pos_ok(row,col) || !empty_pos(row,col))
        row = Dice.random_pos(@nrows)
        col = Dice.random_pos(@ncols)
      end

      pos[@@ROW]=row
      pos[@@COL]=col

      pos
    end

    private
    def put_player2D(oldrow,oldcol,row,col,player)
      output = nil
      if(can_step_on(row,col))
        if(pos_ok(oldrow,oldcol))
          if(@players[oldrow][oldcol] == player)
            update_old_pos(oldrow,oldcol)
            @players[oldrow][oldcol] = nil
          end
        end

        if(monster_pos(row,col))
          @squares[row][col] = @@COMBAT_CHAR
          output = @monsters[row][col]
        else
          @squares[row][col] = player.number
        end

        @players[row][col] = player
        player.set_pos(row,col)
      end

      output
    end
  end
end
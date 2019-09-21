require_relative "board.rb"
require_relative "display.rb"
require_relative "cursor.rb"
require_relative "humanplayer.rb"
require "colorize"

class Game
   def initialize(ai_player = false)
      @board = Board.new
      @display = Display.new(@board, true)

      @player_one = HumanPlayer.new(:white, @display)
      @player_two = ai_player ? AiPlayer.new(:black) : HumanPlayer.new(:black, @display)
      @current_player = @player_one
   end

   def play
      until gameover
         @display.render
         @current_player.make_move(@board)
         switch_player
      end
   end

   def gameover
      @board.checkmate?(:black) || @board.checkmate?(:white) 
   end

   def switch_player
      @current_player = @current_player == @player_one ? @player_two : @player_one
   end   
   
end

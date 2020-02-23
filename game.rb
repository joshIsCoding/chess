require_relative "board.rb"
require_relative "display.rb"
require_relative "cursor.rb"
require_relative "humanplayer.rb"
require "colorize"

class Game
   def initialize(ai_player = false, debug_mode = false)
      @board = Board.new
      @display = Display.new(@board, debug_mode)

      @player_one = HumanPlayer.new(:white, @display)
      @player_two = ai_player ? AiPlayer.new(:black) : HumanPlayer.new(:black, @display)
      @current_player = @player_one
   end

   def play
      until gameover
         @display.render
         notify_players
         @current_player.make_move(@board)
         swap_turn!
      end
      winner = @board.checkmate?(:black) ? @player_one : @player_two
      gameover_message(winner)
   end

   private

   def gameover
      @board.checkmate?(:black) || @board.checkmate?(:white) 
   end

   def notify_players
      puts "Player #{@current_player.player_no}, it's your turn to move the #{@current_player.piece_color.to_s} pieces."
   end

   def swap_turn!
      @current_player = @current_player == @player_one ? @player_two : @player_one
   end
   
   def gameover_message(winner)
      puts "Checkmate! Congratulations, Player #{winner.player_no}, you win!"
   end
   
end

if $PROGRAM_NAME == __FILE__
   new_game = Game.new
   new_game.play
end

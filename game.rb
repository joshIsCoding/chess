class Game
   def initialize(AI_player = false)
      @board = Board.new
      @display = Display.new(@board, true)

      @player_one = HumanPlayer.new(:white)
      @player_two = AI_player ? AiPlayer.new(:black) : HumanPlayer.new(:black)
      @current_player = @player_one
   end

   def play
   end

   
   
   
end

class HumanPlayer
   attr_reader :piece_color
   def initialize(piece_color, display)
      @piece_color, @display = piece_color, display
   end

   def make_move(board)
      
      begin
         move = []
         until move.length == 2
            move << get_pos
         end
         board.move_piece(piece_color, *move)     
         
      rescue ArgumentError => move_error
         puts move_error
         move.each { |pos| board[pos].toggle_selected }    
         retry

      ensure
         board[move.last].toggle_selected if move.length > 0 
      end
   end

   def get_pos
      input = nil
         until input.is_a?(Array)
            input = @display.cursor.get_input
            @display.render
         end
      input
   end
end
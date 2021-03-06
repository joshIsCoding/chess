require_relative "slideable.rb"
require_relative "stepable.rb"
class Piece
   attr_reader :color, :pos, :board, :selected
   def initialize(color, pos, board)
      @color, @pos, @board = color, pos, board
      board.add_piece(self, pos)
      @selected = false
   end

   def pos=(new_pos)
      if !@pos || @board[new_pos] == self
         @pos = new_pos
      end
   end

   def valid_moves
      moves.reject{ |move| move_into_check?(move)}
   end
      

   def symbol
      raise NotImplementedError
   end

   def empty?
      false
   end

   def toggle_selected
      @selected = !selected unless empty?
   end

   private

   def move_into_check?(end_pos)
      dummy_board = board.dup
      dummy_board.move_piece!(pos, end_pos)
      dummy_board.in_check?(dummy_board[end_pos].color)
   end

end
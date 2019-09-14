require_relative "slideable.rb"
require_relative "stepable.rb"
class Piece
   attr_reader :color, :pos, :board
   def initialize(color, pos, board)
      @color, @pos, @board = color, pos, board
      board.add_piece(self, pos)
   end

   def pos=(new_pos)
      if !@pos || @board[new_pos] == self
         @pos = new_pos
      end
   end

   def valid_moves
      begin
         return moves
      rescue
         return [[4,4],[4,3],[4,2]]
      end
   end
      

   def symbol
      raise NotImplementedError
   end

   def empty?
      false
   end

   private

   def move_into_check?(end_pos)
      dummy_board = board.dup
      dummy_board.move_piece(pos, end_pos)
      dummy_board.in_check?
   end

end
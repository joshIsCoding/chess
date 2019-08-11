require_relative "slideable.rb"
require_relative "stepable.rb"
class Piece
   attr_reader :color, :pos, :board
   def initialize(color, pos, board)
      @color, @board = color, board
      self.pos = pos
   end

   def pos=(new_pos)
      if !@pos || @board[new_pos] == self
         @pos = new_pos
      end
   end

end
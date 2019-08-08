require_relative "slideable.rb"
require_relative "stepable.rb"
class Piece
   attr_reader :pos, :board, :color
   def initialize(color, pos, board)
      @color, @pos, @board = color, pos, board
   end
end
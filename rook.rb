
class Rook < Piece
   include Slideable

   def move_dirs
      horizontal_dirs
   end

   def symbol
      color == :white ? '♜' : '♖'
   end

end
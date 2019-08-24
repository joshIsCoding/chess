
class Rook < Piece
   include Slideable

   def move_dirs
      horizontal_dirs
   end

   def symbol
      :R
   end

end
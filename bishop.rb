
class Bishop < Piece
   include Slideable

   def move_dirs
      diagonal_dirs
   end

   def symbol
      :B
   end

end
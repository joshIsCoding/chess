
class Pawn < Piece

   def move_dirs
   end

   def symbol
      :P
   end

   def forward_dir 
      if @color == :white
         return 1 
      else
         return -1
      end
   end

end
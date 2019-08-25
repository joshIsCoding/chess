
class Pawn < Piece

   def moves
      if at_start_row?
         return [forward_steps(1), forward_steps(2)].filter{ |move| @board[move].empty? }
      elsif @board[forward_steps(1)].empty?
         return [forward_steps(1)]
      else
         return []
      end
   end

   def symbol
      :P
   end

   private

   def forward_dir 
      if @color == :white
         return 1 
      else
         return -1
      end
   end

   def forward_steps(count)
      [@pos.first, @pos.last + count]
   end

   def at_start_row?
      (@color == :white && @pos.last == 1) || (@color == :black && @pos.last == 0)
   end

end
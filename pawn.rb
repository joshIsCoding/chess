
class Pawn < Piece

   def moves
      moves = []
      [1,2].each do |step|
         break if !at_start_row? && step == 2
         move = forward_steps(step)
         
         break if !@board[move].empty? 
         moves << move if @board.valid_pos?(move)
      end
      return moves
   end

   def symbol
      :P
   end

   private

   def forward_dir 
      @color == :white ? 1 : -1
   end

   def forward_steps(count)
      x, y = @pos
      [x, y + count * forward_dir]
   end

   def at_start_row?
      (@color == :white && @pos.last == 1) || (@color == :black && @pos.last == 0)
   end

end

class Pawn < Piece

   def moves
      forward_steps + side_attacks
   end

   def symbol
      :P
   end

   private

   def forward_dir 
      @color == :white ? 1 : -1
   end

   def forward_steps
      x, y = @pos
      steps = []
      [1,2].each do |step|
         break if !at_start_row? && step == 2
         move = [x, y + step * forward_dir]
         
         break unless @board.empty?(move)
         steps << move if @board.valid_pos?(move)
      end
      return steps
   
   end

   def side_attacks
      x, y = @pos
      side_attacks = [[x-1, y + forward_dir], [x+1, y + forward_dir]]
      side_attacks.select do |move|
         next false unless @board.valid_pos?(move)
         next false if @board.empty?(move)
         target = @board[move]
         target.color != @color
      end
   end



   def at_start_row?
      (@color == :white && @pos.last == 1) || (@color == :black && @pos.last == 6)
   end

end
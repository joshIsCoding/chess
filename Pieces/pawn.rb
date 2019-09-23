
class Pawn < Piece

   def moves
      forward_steps + side_attacks
   end

   def symbol
      '♟'.colorize(color)
   end

   private

   def forward_dir 
      @color == :white ? -1 : 1
   end

   def forward_steps
      row, col = @pos
      steps = []
      [1,2].each do |step|
         break if !at_start_row? && step == 2
         move = [row + step * forward_dir, col]
         
         break unless @board.empty?(move)
         steps << move if @board.valid_pos?(move)
      end
      return steps
   
   end

   def side_attacks
      row, col = @pos
      side_attacks = [[row + forward_dir, col-1], [row + forward_dir, col+1]]
      side_attacks.select do |move|
         next false unless @board.valid_pos?(move)
         next false if @board.empty?(move)
         target = @board[move]
         target.color != @color
      end
   end



   def at_start_row?
      (@color == :white && @pos.first == 6) || (@color == :black && @pos.first == 1)
   end

end
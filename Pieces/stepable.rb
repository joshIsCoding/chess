module Stepable
   def moves 
      moves = []
      move_diffs.each do |diff|
         new_move = [self.pos[0] + diff[0], self.pos[1] + diff[1]]
         next unless self.board.valid_pos?(new_move)
         moves << new_move if board.empty?(new_move) || self.board[new_move].color != self.color
      end
      moves
   end

   def move_diffs
      move_diffs = []
      (-1..1).each do |di|
         (-1..1).each do |dj|
            next if di == 0 && dj == 0
            move_diffs << [di, dj]
         end
      end
      move_diffs
   end

end

module Stepable
   def moves 
      moves = []
      move_diffs.each do |diff|
         new_move = [self.pos[0] + diff[0], self.pos[1] + diff[1]]
         next if new_move.min < 0 || new_move.max >= 8
         # next if !self.board[new_move].empty?
         moves << new_move
      end
      moves
   end

   def move_diffs
      move_diffs = []
      (-1..1).each do |dx|
         (-1..1).each do |dy|
            next if dx == 0 && dy == 0
            move_diffs << [dx, dy]
         end
      end
      move_diffs
   end

end

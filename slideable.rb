module Slideable
   HORIZONTAL_DIRS = [[1, 0], [0, -1], [-1, 0], [0, 1]]
   DIAGONAL_DIRS = [[1,1], [1,-1], [-1, -1], [-1, 1]]
   
   def horizontal_dirs
      horizontal_moves = Hash.new { |h, k| h[k] = [] }
      (1...8).each do |increment|
         HORIZONTAL_DIRS.each do |dir|
            new_move = [self.pos[0] + dir[0] * increment,  self.pos[1] + dir[1] * increment ]
            horizontal_moves[dir].push(new_move) if new_move.min >= 0 && new_move.max < 8
            
         end
      end
      horizontal_moves
   end

            
end
module Slideable
   HORIZONTAL_DIRS = [[1, 0], [0, -1], [-1, 0], [0, 1]]
   DIAGONAL_DIRS = [[1,1], [1,-1], [-1, -1], [-1, 1]]
   
   def horizontal_dirs
      horizontal_moves = Hash.new
      HORIZONTAL_DIRS.each do |dir|
         unblocked_moves = grow_unblocked_moves_in_dir(dir)
         next if unblocked_moves.empty?
         horizontal_moves[dir] = unblocked_moves
      end
      horizontal_moves
   end

   def diagonal_dirs
      diagonal_moves = Hash.new
      DIAGONAL_DIRS.each do |dir|
         unblocked_moves = grow_unblocked_moves_in_dir(dir)
         next if unblocked_moves.empty?
         diagonal_moves[dir] = unblocked_moves
      end
      diagonal_moves
   end

   def grow_unblocked_moves_in_dir(dir)
      dir_moves = []
      (1...8).each do |increment|
            new_move = [pos[0] + dir[0] * increment,  pos[1] + dir[1] * increment ]
            break if !board.valid_pos?(new_move)
            if board.empty?(new_move)
               dir_moves.push(new_move) 
            else 
               dir_moves.push(new_move) if board[new_move].color != color
               break
            end            
            
         end
      dir_moves
      
   end

   def move_dirs
      horizontal_moves = horizontal_dirs
      diagonal_moves = diagonal_dirs
      horizontal_moves.merge(diagonal_moves)
   end

   def moves
      move_dirs.values.inject([]) { |new_dir, move_array| new_dir + move_array }
   end

      


            
end
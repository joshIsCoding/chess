
class Knight < Piece
   include Stepable

   def move_diffs
      increments = [-2,-1, 1, 2]
      move_increments = []
      increments.each do |i|
         increments.each do |j|
            next if j.abs == i.abs
            move_increments << [i, j]
         end
      end
      move_increments
   end



   def symbol
      :k
   end

end
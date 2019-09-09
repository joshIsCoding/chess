
class Queen < Piece
   include Slideable

   def symbol
      color == :white ? '♛' : '♕'
   end

end
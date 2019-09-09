
class King < Piece
   include Stepable

   def symbol
      color == :white ? '♚' : '♔'
   end

end
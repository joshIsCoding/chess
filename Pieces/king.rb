
class King < Piece
   include Stepable

   def symbol
      '♚'.colorize(color)
   end

end
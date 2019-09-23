
class Queen < Piece
   include Slideable

   def symbol
      '♛'.colorize(color)
   end

end
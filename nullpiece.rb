
class Nullpiece < Piece
   include Singleton
   
   def initialize
      @color = :nil
   end

   def moves
   end

   def symbol
      :null
   end

end
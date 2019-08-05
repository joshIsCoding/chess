require_relative "slideable.rb"
class Piece
   include Slideable
   attr_reader :pos
   def initialize(pos)
      @pos = pos
   end
end
require_relative "slideable.rb"
require_relative "stepable.rb"
class Piece
   include Stepable
   attr_reader :pos
   def initialize(pos)
      @pos = pos
   end
end
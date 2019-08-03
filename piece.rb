require_relative "slideable.rb"
class Piece
   include Slideable
   attr_reader :pos
   def initialize
      @pos = [4,4]
   end
end
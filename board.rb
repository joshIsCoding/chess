require 'singleton'
require 'byebug'
require_relative "Pieces/piece.rb"
require_relative "Pieces/pawn.rb"
require_relative "Pieces/bishop.rb"
require_relative "Pieces/queen.rb"
require_relative "Pieces/rook.rb"
require_relative "Pieces/king.rb"
require_relative "Pieces/knight.rb"
require_relative "Pieces/nullpiece.rb"

class Board
   attr_reader :rows
   LAYOUT = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook ]
   
   def initialize
      @rows = Array.new(8) { Array.new(8, Nullpiece.instance) }
      set_pieces
   end

   def move_piece(start_pos, end_pos)
      target_piece = self[start_pos]
      raise ArgumentError.new("There is no piece at this start position.") if target_piece.empty?
      raise ArgumentError.new("The #{target_piece.symbol} cannot move to square #{end_pos.first} #{end_pos.last}")  unless target_piece.valid_moves.include?(end_pos)
      self[start_pos] = Nullpiece.instance
      self[end_pos] = target_piece
      target_piece.pos = end_pos
      
   end

   def set_pieces
      [0, 1, 6, 7].each do |y|
         (0...8).each do |x| 
            piece = y == 0 || y == 7 ? LAYOUT[x] : Pawn
            piece_pos = [x, y]
            add_piece(piece, piece_pos)
         end
      end
   end

   def add_piece(piece, pos)
      if [0,1].include?(pos.last)
         color = :white
      elsif [6,7].include?(pos.last)
         color = :black
      end

      self[pos] = piece.new(color, pos, self) 

   end

   def [](pos)
      col, row = pos 
      @rows[row][col]
   end

   def []=(pos, value)
      col, row = pos
      @rows[row][col] = value
   end

   def valid_pos?(pos)
      pos.min >= 0 && pos.max < 8
   end

   def empty?(pos)
      self[pos].empty?
   end

end
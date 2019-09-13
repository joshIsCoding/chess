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
      [0,7].each do |row|
         fill_back_row(row)
      end
      [1,6].each do |row|
         fill_pawn_row(row)
      end
   end

   def fill_back_row(row)
      color = row == 0 ? :black : :white 
      LAYOUT.each_with_index { |piece, col| piece.new(color, [row, col], self) }
   end

   def fill_pawn_row(row)
      color = row == 1 ? :black : :white
      8.times { |col| Pawn.new(color, [row, col], self)}
   end
    
   def add_piece(piece, pos)
      raise "Square already occupied" unless empty?(pos)
      self[pos] = piece
   end


   def [](pos)
      row, col = pos 
      @rows[row][col]
   end

   def []=(pos, value)
      row, col = pos
      @rows[row][col] = value
   end

   def valid_pos?(pos)
      pos.min >= 0 && pos.max < 8
   end

   def empty?(pos)
      self[pos].empty?
   end

   def find_king(color)
      king = pieces.find { | piece| piece.is_a?(King) && piece.color == color }
      king.pos
   end

   def pieces
      @rows.flatten.reject(&:empty?)
   end


end
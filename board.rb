require 'singleton'
require 'byebug'
require_relative "piece.rb"
require_relative "bishop.rb"
require_relative "nullpiece.rb"

class Board
   attr_reader :rows
   LAYOUT = [:rook, :knight, :bishop, :queen, :king, :bishop, :knight, :rook ]
   
   def initialize
      @rows = Array.new(8) { Array.new(8, Nullpiece.instance) }
      set_pieces
   end

   def move_piece(start_pos, end_pos)
      target_piece = self[start_pos]
      raise ArgumentError.new("There is no piece at this start position.") if target_piece.empty?
      raise ArgumentError.new("The #{target_piece.symbol} cannot move to square #{end_pos.first} #{end_pos.last}") if !target_piece.valid_moves.include?(end_pos)
      self[start_pos] = Nullpiece.instance
      self[end_pos] = target_piece
      target_piece.pos = end_pos
      
   end

   def set_pieces
      [0, 1, 6, 7].each do |row|
         (0...8).each do |col| 
            piece = row == 0 || row == 7 ? LAYOUT[col] : :pawn
            piece_pos = [col, row]
            add_piece(piece, piece_pos)
         end
      end
   end

   def add_piece(piece, pos)
      if [0,1].include?(pos.last)
         color = :white
      elsif [6,7].include?(pos.last)
         color = :black
      else
         color = :nil
      end

      case piece
      when :bishop
         self[pos] = Bishop.new(color, pos, self)
      else
         self[pos] = Piece.new(color, pos, self)
      end
         
   end

   def [](pos)
      col, row = pos 
      @rows[row][col]
   end

   def []=(pos, value)
      col, row = pos
      @rows[row][col] = value
   end

end
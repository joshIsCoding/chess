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
   
   def initialize(empty_board = false)
      @rows = Array.new(8) { Array.new(8, Nullpiece.instance) }
      set_pieces unless empty_board
   end

   def test_check
      display = Display.new(self)
      display.render
      sleep 1
      move_piece([6,5],[5,5])
      move_piece([1,4],[3,4])
      move_piece([6,6],[4,6])
      move_piece([0,3],[4,7])
      display.render
      puts in_check?(:white)
      puts checkmate?(:white)

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

   def dup
      duped_board = Board.new(true)
      rows.each do |row|
         row.each do |original_piece|
            next if original_piece.empty?
            dup_class = original_piece.class
            dup_class.new(original_piece.color, original_piece.pos, duped_board)
         end
      end
      duped_board
   end

   def in_check?(color)
      king_pos = find_king(color)
      pieces.reject { |piece| piece.color == color }.any? do |opponent_piece|
         opponent_piece.moves.include?(king_pos)
      end
   end

   def checkmate?(color)
      in_check?(color) && pieces.all? { |piece| piece.color == color && piece.valid_moves.empty? }
   end



end
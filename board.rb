require_relative "piece.rb"

class Board
   attr_reader :rows
   LAYOUT = [:rook, :knight, :bishop, :queen, :king, :bishop, :knight, :rook ]
   
   def initialize
      @rows = Array.new(8) { Array.new(8) }
      set_pieces
   end

   def move_piece(start_pos, end_pos)
      target_piece = self[start_pos]
      raise ArgumentError.new("There is no piece at this start position.") if target_piece.nil?
      
      self[start_pos] = nil
      self[end_pos] = target_piece
   end

   def set_pieces
      (0...8).each do |col|
         [0,1,6,7].each { |row| add_piece(Piece.new, [col, row])}
      end
   end

   def add_piece(piece, pos)
      self[pos] = piece
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
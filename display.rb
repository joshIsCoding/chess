require_relative "board.rb"
require_relative "cursor.rb"
require "colorize"

class Display
   COLUMNS = ("a".."h").to_a.freeze
   ROWS = (1..8).to_a.reverse!.freeze 

   def initialize(board)
      @cursor = Cursor.new([0,0], board)
      @board = board
   end

   def render
      render_alphabet_labels
      puts
      @board.rows.each_with_index do |row, i| 
         render_row(row, i) 
         puts
      end
      render_alphabet_labels

   end

   def render_alphabet_labels
   end

   def render_row(row_array, row_num)
      spacer = "   "
      row_string = ROWS[row_num].to_s + spacer
      row_array.each do |piece| 
         piece_string = piece.symbol + spacer
         row_string << piece_string
      end
      row_string << ROWS[row_num].to_s

      puts row_string
   end


end
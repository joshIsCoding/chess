require_relative "board.rb"
require_relative "cursor.rb"
require "colorize"

class Display
   COLUMNS = ("a".."h").to_a.freeze
   ROWS = (1..8).to_a.reverse!.freeze

   def initialize(board = Board.new)
      @cursor = Cursor.new([0,0], board)
      @board = board
   end

   def test
      @board = Board.new
      while @board
         self.render
         @cursor.get_input
      end
   end

   def render
      system("clear")
      render_alphabet_labels
      puts
      build_grid.each do |row|
         puts row
         puts
      end
      render_alphabet_labels

   end

   def render_alphabet_labels
      alphabet_labels = "  "
      COLUMNS.each { |letter| alphabet_labels << " " + letter + "   " }
      puts alphabet_labels
   end

   def build_grid
      @board.rows.map.with_index do |row, i| 
         build_row(row, i)
      end
   end

   def build_row(row_array, row_num)
      row_string = ROWS[row_num].to_s + " " 
      processed_row = row_array.map.with_index do |piece, col_num|
         pos = [row_num, col_num]
         piece_char = " " + piece.symbol + " "
         piece_char.colorize(color_values(pos)) + " "
      end

      row_string << processed_row.join(" ") + " " + ROWS[row_num].to_s

      row_string
   end

   def color_values(pos)
      if pos == @cursor.cursor_pos && @cursor.selected
         fg, bg = :white, :green
      elsif pos == @cursor.cursor_pos
         fg, bg = :black, :light_green
      elsif (pos.first + pos.last).even?
         fg, bg = :white, :light_blue
      else
         fg, bg = :black, :light_yellow
      end
      { :color => fg, :background => bg }
   end




end
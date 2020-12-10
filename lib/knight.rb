require_relative 'board.rb'

class Knight
    attr_reader :color 
    attr_accessor :row, :column

    def initialize(row, column, color)  
      @row = row
      @column = column
      @color = color
    end
     #search if its possible to have put_on_board in the knight class
       
     
end
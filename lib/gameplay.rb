require_relative 'connect_four.rb'

class Game
  def initialize
    @player1 = Player.new('Player 1', "\u26be")
    @player2 = Player.new('Player 2', "\u26ab")
    @board = Board.new
  end

  def column_request
    puts 'What column would you like to play into?'
    column = gets.to_i
    if column < 1 || column > 7
      puts 'This is not a valid column. Please choose a valid column.'
      column_request
    end
  end

  def token_drop
    column = column_request
    columns_cells = @board.cells.select do |cell|
      cell.last == column
    end
    columns_cells.sort
    return columns_cells.first
  end
end

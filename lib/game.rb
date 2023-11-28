require_relative 'player.rb'
require_relative 'board.rb'

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

  def locate_token_drop
    column = column_request
    columns_cells = @board.cells.select do |cell|
      cell.last == column
    end
    columns_cells.sort
    return columns_cells.first
  end

  def over?
    return true if @player1.winner?
    return true if @player2.winner?
    return true if @board.full?
    false
  end
end

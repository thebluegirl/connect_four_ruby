require_relative 'player'
require_relative 'board'

class Game
  def initialize
    @player1 = Player.new('Player 1', '⚪')
    @player2 = Player.new('Player 2', '⚫')
    @board = Board.new
  end

  def column_request
    puts 'What column would you like to play into?'
    column = gets.to_i
    return column unless column < 1 || column > 7

    puts 'This is not a valid column. Please choose a valid column.'
    column_request
  end

  def locate_token_drop
    column = column_request
    columns_cells = @board.cells.select do |cell|
      cell.last == column
    end
    columns_cells.sort
    columns_cells.first
  end

  def over?
    return true if @player1.winner?
    return true if @player2.winner?
    return true if @board.full?

    false
  end

  def player_turn(player)
    puts "#{player.player}'s turn..."
    cell = locate_token_drop
    @board.fill_cell(cell, player.symbol)
    player.add_slot(cell)
    @board.print_board
  end

  def end_message
    puts "#{@player1.player} wins!!!" if @player1.winner?
    puts "#{@player2.player} wins!!!" if @player2.winner?
    puts "It's a tie. You both win!" if @board.full? && !@player1.winner? && !@player2.winner?
  end
end

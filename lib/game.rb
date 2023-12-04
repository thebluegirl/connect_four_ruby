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
    if columns_cells.empty?
      puts 'This column is full. Please choose another.'
      return locate_token_drop
    end
    columns_cells.sort.first
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
    player.add_slot(cell)
    @board.fill_cell(cell, player.symbol)
    @board.print_board
  end

  def end_message
    puts "#{@player1.player} wins!!!" if @player1.winner?
    puts "#{@player2.player} wins!!!" if @player2.winner?
    puts "It's a tie. You both win!" if @board.full? && (!@player1.winner? && !@player2.winner?)
  end

  def request_another_game
    puts 'Would you like to play another game?'
    response = gets.chomp.downcase
    if response == 'yes' || response == 'y'
      Game.new.play
    elsif response == 'no' || response == 'n'
      return
    else
      puts "This is not a valid response. Please enter 'no', 'yes', or the first letter of either of the two."
      request_another_game
    end
  end

  def play
    @board.print_board
    until over?
      player_turn(@player1)
      player_turn(@player2) unless over?
    end
    end_message
    request_another_game
  end
end

class Player
  def initialize(player, symbol)
    @player = player
    @symbol = symbol
    @slots_played = []
  end
end

class Board
  def initialize
    @rows = Array(1..6)
    @columns = Array(1..7)
    @cells = create_cells
  end

  def create_cells
    cells = []
    @rows.each do |row|
      @columns.each do |column|
        cell = []
        cell << row
        cell << column
        cells << cell
      end
    end
    return cells
  end

  def print_board
    @cells.each do |cell|
      print '|__|' if cell.first == 1
    end
    puts

    @cells.each do |cell|
      print '|__|' if cell.first == 2
    end
    puts

    @cells.each do |cell|
      print '|__|' if cell.first == 3
    end
    puts

    @cells.each do |cell|
      print '|__|' if cell.first == 4
    end
    puts

    @cells.each do |cell|
      print '|__|' if cell.first == 5
    end
    puts

    @cells.each do |cell|
      print '|__|' if cell.first == 6
    end
    puts
  end

  # protected

  attr_reader :rows, :columns
end

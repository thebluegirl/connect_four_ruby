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
      if cell.first == 6
        cell.count > 2 ? (print "|#{cell[2]}|") : (print '|__|')
      end
    end
    puts

    @cells.each do |cell|
      if cell.first == 5
        cell.count > 2 ? (print "|#{cell[2]}|") : (print '|__|')
      end
    end
    puts

    @cells.each do |cell|
      if cell.first == 4
        cell.count > 2 ? (print "|#{cell[2]}|") : (print '|__|')
      end
    end
    puts

    @cells.each do |cell|
      if cell.first == 3
        cell.count > 2 ? (print "|#{cell[2]}|") : (print '|__|')
      end
    end
    puts

    @cells.each do |cell|
      if cell.first == 2
        cell.count > 2 ? (print "|#{cell[2]}|") : (print '|__|')
      end
    end
    puts

    @cells.each do |cell|
      if cell.first == 1
        cell.count > 2 ? (print "|#{cell[2]}|") : (print '|__|')
      end
    end
    puts
  end

  def fill_cell(cell, symbol)
    index = @cells.index(cell)
    @cells[index] << symbol
  end

  def full?
    cells.each do |cell|
      return false if cell.count < 3
    end
    true
  end
  # protected

  attr_reader :rows, :columns, :cells
end

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
    cells
  end

  def print_board
    print_row = lambda do |num|
      @cells.each do |cell|
        if cell.first == num
          cell.count > 2 ? (print "|#{cell[2]}|") : (print '|__|')
        end
      end
    end

    print_row.call(6)
    puts
    print_row.call(5)
    puts
    print_row.call(4)
    puts
    print_row.call(3)
    puts
    print_row.call(2)
    puts
    print_row.call(1)
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

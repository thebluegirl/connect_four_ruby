class Player
  def initialize

  end
end

class Board
  def initialize
    @rows = Array(1..6)
    @columns = Array(1..7)
    @cells = create_cells
  end

  def create_cells
    cells = Array.new
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

  # protected

  attr_reader :rows, :columns
end

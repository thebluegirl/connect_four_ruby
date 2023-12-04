class Player
  attr_accessor :slots_played
  attr_reader :player, :symbol

  def initialize(player, symbol)
    @player = player
    @symbol = symbol
    @slots_played = []
  end

  def add_slot(cell)
    unmodified_cell_copy = [cell[0], cell[1]]
    @slots_played << unmodified_cell_copy
  end

  def winner?
    return true if row_win?
    return true if column_win?
    return true if diagonal_win?

    false
  end

  def row_win?
    horizontal_cells = lambda do |cell|
      [[cell[0], cell[1] + 1], [cell[0], cell[1] + 2], [cell[0], cell[1] + 3]]
    end

    cell_check = lambda do |array|
      array.each do |cell|
        return false unless @slots_played.include?(cell)
      end

      true
    end

    @slots_played.each do |cell|
      horizontal_array = horizontal_cells.call(cell)
      cell_check.call(horizontal_array) ? (return true) : next
    end

    false
  end

  def column_win?
    vertical_cells = lambda do |cell|
      [[cell[0] + 1, cell[1]], [cell[0] + 2, cell[1]], [cell[0] + 3, cell[1]]]
    end

    cell_check = lambda do |array|
      array.each do |cell|
        return false unless @slots_played.include?(cell)
      end

      true
    end

    @slots_played.each do |cell|
      vertical_array = vertical_cells.call(cell)
      cell_check.call(vertical_array) ? (return true) : next
    end

    false
  end

  def diagonal_win?
    diagonal_cells = lambda do |cell|
      [[cell[0] + 1, cell[1] + 1], [cell[0] + 2, cell[1] + 2], [cell[0] + 3, cell[1] + 3]]
    end

    cell_check = lambda do |array|
      array.each do |cell|
        return false unless @slots_played.include?(cell)
      end

      true
    end

    @slots_played.each do |cell|
      diagonal_array = diagonal_cells.call(cell)
      cell_check.call(diagonal_array) ? (return true) : next
    end
    false
  end
end

class Player
  attr_accessor :slots_played
  attr_reader :player, :symbol

  def initialize(player, symbol)
    @player = player
    @symbol = symbol
    @slots_played = []
  end

  def add_slot(cell)
    @slots_played << cell
  end

  def winner?
    return true if row_win?
    return true if column_win?
    return true if diagonal_win?

    false
  end

  def row_win?
    1..6.times do |num|
      row =
        @slots_played.filter do |cell|
          cell.first == num
        end.sort
      next if row.count < 4

      columns = []
      row.each { |cell| columns << cell.last }

      in_sequence = lambda do |array, columns|
        array.each do |number|
          return false unless columns.include?(number)
        end
        true
      end

      return true if in_sequence.call([1, 2, 3, 4], columns)
      return true if in_sequence.call([2, 3, 4, 5], columns)
      return true if in_sequence.call([3, 4, 5, 6], columns)
      return true if in_sequence.call([4, 5, 6, 7], columns)
    end
    false
  end

  def column_win?
    1..7.times do |num|
      column =
        @slots_played.filter do |cell|
          cell.last == num
        end.sort
      next if column.count < 4

      rows = []
      column.each { |cell| rows << cell.first }

      in_sequence = lambda do |array, rows|
        array.each do |number|
          return false unless rows.include?(number)
        end
        true
      end

      return true if in_sequence.call([1, 2, 3, 4], rows)
      return true if in_sequence.call([2, 3, 4, 5], rows)
      return true if in_sequence.call([3, 4, 5, 6], rows)
    end
    false
  end

  def diagonal_win?
    diagonal_cells = lambda do |cell|
      [[cell[0] + 1, cell[1] + 1], [cell[0] + 2, cell[1] + 2], [cell[0] + 3, cell[1] + 3]]
    end

    @slots_played.each do |cell|
      diagonal_array = diagonal_cells.call(cell)
      if @slots_played.include?(diagonal_array[0]) && @slots_played.include?(diagonal_array[1]) && @slots_played.include?(diagonal_array[2])
        return true
      else
        next
      end
    end
    false
  end
end

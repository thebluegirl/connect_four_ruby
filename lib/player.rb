class Player
  attr_accessor :slots_played

  def initialize(player, symbol)
    @player = player
    @symbol = symbol
    @slots_played = []
  end

  def add_slot(cell)
    @slots_played << cell
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

      def in_sequence?(array, columns)
        array.each do |number|
          return false if !columns.include?(number)
        end
        return true
      end

      return true if in_sequence?([1, 2, 3, 4], columns)
      return true if in_sequence?([2, 3, 4, 5], columns)
      return true if in_sequence?([3, 4, 5, 6], columns)
      return true if in_sequence?([4, 5, 6, 7], columns)
    end
    return false
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

      def in_sequence?(array, rows)
        array.each do |number|
          return false if !rows.include?(number)
        end
        return true
      end

      return true if in_sequence?([1, 2, 3, 4], rows)
      return true if in_sequence?([2, 3, 4, 5], rows)
      return true if in_sequence?([3, 4, 5, 6], rows)
    end
    return false
  end
end

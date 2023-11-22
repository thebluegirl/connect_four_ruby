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
end

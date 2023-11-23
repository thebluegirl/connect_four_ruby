require './lib/player'

describe Player do
  describe '#add_slot' do
    subject(:player) {described_class.new('Player', "\u26be")}
    it 'increases the number of slots played' do
      players_slots = player.instance_variable_get(:@slots_played)
      cell = [1, 1]
      expect{ player.add_slot(cell) }.to change{ players_slots.count }.by(1)
    end

    it 'adds the slot to the player instance object' do
      players_slots = player.instance_variable_get(:@slots_played)
      cell = [1, 1]
      player.add_slot(cell)
      expect(players_slots.include?(cell)).to be true
    end
  end

  describe '#row_win?' do
    subject(:player) { described_class.new('Player', "\u26be") }
    context 'when player has played four in a row' do
      before do
        slots_played = player.instance_variable_get(:@slots_played)
        cells = [[1, 1], [1, 2], [1, 3], [1, 4]]
        cells.each { |cell| slots_played << cell }
      end

      it 'returns true' do
        expect(player).to be_row_win
      end
    end

    context 'when player has not played up to four on any row' do
      before do
        slots_played = player.instance_variable_get(:@slots_played)
        cells = [[1, 1], [1, 2], [1, 3]]
        cells.each { |cell| slots_played << cell }
      end

      it 'returns false' do
        expect(player).not_to be_row_win
      end
    end
  end
end

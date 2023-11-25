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

      it { is_expected.to be_row_win }
    end

    context 'when player has played more than four on a row' do
      before do
        slots_played = player.instance_variable_get(:@slots_played)
        cells = [[2, 2], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7]]
        cells.each { |cell| slots_played << cell }
      end

      it {is_expected.to be_row_win}
    end

    context 'when player has not played up to four on any row' do
      before do
        slots_played = player.instance_variable_get(:@slots_played)
        cells = [[1, 1], [1, 2], [1, 3]]
        cells.each { |cell| slots_played << cell }
      end

      it { is_expected.not_to be_row_win }
    end

    context 'when a player has not played up to four consequtively in a row' do
      before do
        slots_played = player.instance_variable_get(:@slots_played)
        cells = [[1, 1], [1, 2], [1, 3], [1, 6], [2, 2], [2, 3], [2, 4]]
        cells.each { |cell| slots_played << cell }
      end

      it { is_expected.not_to be_row_win }
    end

    context 'when player has not played in any row' do
      it {is_expected.not_to be_row_win}
    end
  end

  describe '#column_win?' do
    subject(:player) { described_class.new('Player', "\u26ab") }
    context 'when player plays four in a column' do
      before do
        slots_played = player.instance_variable_get(:@slots_played)
        cells = [[1, 1], [2, 1], [3, 1], [4, 1]]
        cells.each { |cell| slots_played << cell }
      end

      it {is_expected.to be_column_win}
    end

    context 'when player plays more than four in a column' do
      before do
        slots_played = player.instance_variable_get(:@slots_played)
        cells = [[2, 3], [3, 3], [4, 3], [5, 3], [6, 3], [7, 3]]
        cells.each { |cell| slots_played << cell }
      end

      it {is_expected.to be_column_win}
    end

    context 'when a player has not played up to four on any column' do
      before do
        slots_played = player.instance_variable_get(:@slots_played)
        cells = [[1, 1], [2, 1], [3, 1], [2, 3], [3, 3], [4, 3]]
        cells.each { |cell| slots_played << cell }
      end

      it {is_expected.not_to be_column_win}
    end

    context 'when a player has not played up to four in a column consequtively' do
      before do
        slots_played = player.instance_variable_get(:@slots_played)
        cells = [[1, 1], [2, 1], [4, 1], [5, 1]]
        cells.each { |cell| slots_played << cell }
      end

      it { is_expected.not_to be_column_win }
    end

    context 'when a player has not played any moves' do
      it { is_expected.not_to be_column_win }
    end
  end
end

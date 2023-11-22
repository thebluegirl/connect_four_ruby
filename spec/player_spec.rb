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
end

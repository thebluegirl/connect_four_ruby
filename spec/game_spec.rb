require './lib/game'

describe Game do
  describe '#locate_token_drop' do
    subject(:game) { described_class.new }
    context 'when a valid column is selected' do
      before do
        allow(game).to receive(:column_request).and_return(1)
      end

      it 'returns the first available cell in the column' do
        expect(game.locate_token_drop).to eql([1, 1])
      end
    end
  end

  describe '#drop_token' do
    context 'when player is to drop a token' do
      before do
        player1 = game.instance_variable_get(:@player1)
        player_move = game.drop_token(player1)
        allow(game).to receive(:column_request).and_return(4)
        allow(game).to receive(:locate_token_drop).and_return([1, 4])
        allow(board).to receive(:fill_cell).with([1, 4], "\u26be")
      end

      it 'requests what column the player want to play into' do
        expect(game).to receive(:column_request)
        player_move
      end

      it 'looks for the cell the token will land in' do
        expect(game).to receive(:locate_token_drop)
        player_move
      end

      it 'alters the state of its board object' do
        board = game.instance_variable_get(:@board)
        expect(board).to receive(:fill_cell).with([1, 4], "\u26be")
      end
    end
  end
end

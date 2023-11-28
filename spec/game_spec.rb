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

  describe '#over?' do
    subject(:game) { described_class.new }
    context 'when the board is full' do
      it 'returns true' do
        board = game.instance_variable_get(:@board)
        player1 = game.instance_variable_get(:@player1)
        player2 = game.instance_variable_get(:@player2)
        allow(player1).to receive(:winner?).and_return(false)
        allow(player2).to receive(:winner?).and_return(false)
        allow(board).to receive(:full?).and_return(true)
        expect(game.over?).to be true
      end

    end

    context 'when player 1 wins' do
      it 'returns true' do
        board = game.instance_variable_get(:@board)
        player1 = game.instance_variable_get(:@player1)
        player2 = game.instance_variable_get(:@player2)
        allow(player1).to receive(:winner?).and_return(true)
        allow(player2).to receive(:winner?).and_return(false)
        allow(board).to receive(:full?).and_return(false)
        expect(game.over?).to be true
      end
    end

    context 'when player 2 wins' do
      it 'returns true' do
        board = game.instance_variable_get(:@board)
        player1 = game.instance_variable_get(:@player1)
        player2 = game.instance_variable_get(:@player2)
        allow(player1).to receive(:winner?).and_return(false)
        allow(player2).to receive(:winner?).and_return(true)
        allow(board).to receive(:full?).and_return(false)
        expect(game.over?).to be true
      end
    end

    context 'when game is not over' do
      it 'returns false' do
        board = game.instance_variable_get(:@board)
        player1 = game.instance_variable_get(:@player1)
        player2 = game.instance_variable_get(:@player2)
        allow(player1).to receive(:winner?).and_return(false)
        allow(player2).to receive(:winner?).and_return(false)
        allow(board).to receive(:full?).and_return(false)
        expect(game.over?).to be false
      end
    end
  end

=begin
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
=end
end

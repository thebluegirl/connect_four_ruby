require './lib/game'

describe Game do
  subject(:game) {described_class.new}
  describe '#locate_token_drop' do
    context 'when a valid column is selected' do
      before do
        allow(game).to receive(:column_request).and_return(1)
      end

      it 'returns the first available cell in the column' do
        expect(game.locate_token_drop).to eql([1, 1])
      end
    end

    context 'when a valid but full column is selected' do
      before do
        board = game.instance_variable_get(:@board)
        cells = board.instance_variable_get(:@cells)
        cells.each { |cell| cell << '⚪' if cell.last == 7 }
        allow(game).to receive(:column_request).and_return(7, 1)
      end

      it 'receives request for a column twice' do
        expect(game).to receive(:column_request).twice
        game.locate_token_drop
      end

      it 'puts full column feedback' do
        expect(game).to receive(:puts).with('This column is full. Please choose another.').once
        game.locate_token_drop
      end
    end
  end

  describe '#over?' do
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

  describe '#player_turn' do
    context 'when player is to drop a token' do
      before do
        allow(game).to receive(:locate_token_drop).and_return([1, 4])
      end

      it 'alters the state of that cell' do
        player1 = game.instance_variable_get(:@player1)
        board = game.instance_variable_get(:@board)
        cells = board.instance_variable_get(:@cells)
        cell_index = cells.find_index([1, 4])
        game.player_turn(player1)
        expect(cells[cell_index].include?("⚪")).to be true
      end

      it 'alters the state of the player object' do
        player1 = game.instance_variable_get(:@player1)
        slots_played = player1.instance_variable_get(:@slots_played)
        game.player_turn(player1)
        expect(slots_played.include?([1, 4])).to be true
      end
    end
  end

  describe '#end_message' do
    context 'when game has ended' do
      it 'declears Player 1 as the winner' do
        player1 = game.instance_variable_get(:@player1)
        allow(player1).to receive(:winner?).and_return(true)
        expect(game).to receive(:puts).with("Player 1 wins!!!")
        game.end_message
      end

      it 'declears Player 2 as the winner' do
        player1 = game.instance_variable_get(:@player1)
        player2 = game.instance_variable_get(:@player2)
        allow(player1).to receive(:winner?).and_return(false)
        allow(player2).to receive(:winner?).and_return(true)
        expect(game).to receive(:puts).with("Player 2 wins!!!")
        game.end_message
      end

      it 'declears a tie' do
        player1 = game.instance_variable_get(:@player1)
        player2 = game.instance_variable_get(:@player2)
        board = game.instance_variable_get(:@board)
        allow(player1).to receive(:winner?).and_return(false)
        allow(player2).to receive(:winner?).and_return(false)
        allow(board).to receive(:full?).and_return(true)
        expect(game).to receive(:puts).with("It's a tie. You both win!")
        game.end_message
      end
    end
  end
end

require './lib/gameplay'

describe Game do
  describe '#token_drop' do
    subject(:game) { described_class.new }
    context 'when a valid column is selected' do
      before do
        allow(game).to receive(:column_request).and_return(1)
      end

      it 'returns the first available cell in the column' do
        expect(game.token_drop).to eql([1, 1])
      end
    end
  end
end

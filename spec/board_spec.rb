require './lib/board'

describe Board do
  describe '#create_cells' do
    subject(:board) { described_class.new }
    context 'when method is called' do
      it "creates the board's cells" do
        expect(board.create_cells).to be_an_instance_of Array
      end

      it 'creates 42 cells' do
        cells = board.instance_variable_get(:@cells)
        cell_count = cells.count
        expect(cell_count).to eql(42)
      end

      it 'includes first cell' do
        cells = board.instance_variable_get(:@cells)
        expect(cells).to include([1, 1])
      end

      it 'includes last cell' do
        cells = board.instance_variable_get(:@cells)
        expect(cells).to include([6, 7])
      end
    end
  end

  describe '#fill_cell' do
    subject(:board) { described_class.new }
    it 'finds and fills a cell' do
      cell = [1, 1]
      symbol = "\u26be"
      cells = board.instance_variable_get(:@cells)
      expect{board.fill_cell(cell, symbol)}.to change{ cells.first.count }.by(1)
    end
  end
end

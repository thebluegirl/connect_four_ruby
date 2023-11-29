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
      expect { board.fill_cell(cell, symbol) }.to change { cells.first.count }.by(1)
    end
  end

  describe 'full?' do
    subject(:board) { described_class.new }
    context 'when all cells are full' do
      before do
        cells = board.instance_variable_get(:@cells)
        cells.each_with_index do |cell, index|
          index.even? ? (cell << "\u26be") : (cell << "\u26ab")
        end
      end

      it { is_expected.to be_full }
    end

    context 'when some cells are full' do
      before do
        cells = board.instance_variable_get(:@cells)
        cells.each_with_index do |cell, index|
          cell << "\u26ab" if cell.first == 1
          cell << "\u26be" if cell.first == 2
        end
      end
      it { is_expected.not_to be_full }
    end

    context 'when all cells are empty' do
      it { is_expected.not_to be_full }
    end
  end
end

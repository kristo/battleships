require './board'
require './ship'

describe Board do

  subject(:board) do
    Board.new
  end

  context 'board initialization' do
    it 'creates 10x10 board' do
      expect(board.grid.inject(0) { |sum, cols| sum + cols.size }).to eq 100
    end
  end

  context 'placing ships' do
    describe '#place' do
      it 'creates a board with 3 ships' do
        board.place(Ship.new(5))
        board.place(Ship.new(4))
        board.place(Ship.new(4))
        cells_with_ships = board.grid.flatten.select { |cell| cell.ship }
        cells_with_ships.uniq! { |cell| cell.ship }
        expect(cells_with_ships.size).to eq(3)
      end

      it 'does not create a board with overlapping ships' do
        board.place(Ship.new(5))
        board.place(Ship.new(4))
        board.place(Ship.new(4))
        expect(board.grid.flatten.select { |cell| cell.status == :occupied }.size).to eq(5 + 4 + 4)
      end
    end
  end

  context 'method for the cheaters' do
    describe '#reveal_ships' do
      it 'shows the ships' do
        board.place(Ship.new(5))
        expect(board.reveal_ships).to include('1 2 3 4 5 6 7 8 9 10')
      end
    end
  end

end
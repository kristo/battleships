require './battleships'
require './ship'

describe Battleships do

  subject(:battleships) do
    Battleships.new(Board.new)
  end

  context 'board with one ship' do
    describe '#player_turn' do
      let!(:ship) { Ship.new(2) }

      it 'hits the ship' do
        battleships.board.place(ship)
        coordinates = search_board(battleships.board, ship)
        x, y = coordinates.sample
        expect { battleships.player_turn("#{x}#{y}") }.to output(/Hit/).to_stdout
      end

      it 'misses the ship' do
        expect { battleships.player_turn("A1") }.to output(/Miss/).to_stdout
      end

      it 'sinks the ship' do
        battleships.board.place(ship)
        coordinates = search_board(battleships.board, ship)
        x, y = coordinates[0]
        battleships.player_turn("#{x}#{y}")
        x, y = coordinates[1]
        expect { battleships.player_turn("#{x}#{y}") }.to output(/Hit and sunk/).to_stdout
      end

      it 'completes the game' do
        battleships.board.place(ship)
        coordinates = search_board(battleships.board, ship)
        x, y = coordinates[0]
        battleships.player_turn("#{x}#{y}")
        x, y = coordinates[1]
        expect { battleships.player_turn("#{x}#{y}") }.to output(/Well done! You completed the game in 2 shots/).to_stdout
      end
    end
  end

  private
  def search_board(board, ship)
    ax_y = ('A'..'Z').to_a
    coordinates = []
    board.grid.each_with_index do |row, x|
      row.each_with_index do |col, y|
        coordinates << [ax_y[x], y+1] if col.ship == ship
      end
    end
    coordinates
  end
end
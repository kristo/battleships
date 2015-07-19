require './cell'

class Board

  attr_reader :grid

  BOARD_SIZE = 10

  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) { Cell.new } }
  end

  def place(ship)
    fail "Ship too long" if ship.squares > BOARD_SIZE
    loop do
      cells = select_cells(ship.squares)
      redo if overlapped?(cells)
      cells.map do |cell|
        cell.status = :occupied
        cell.ship = ship
      end
      return cells
    end
  end

  def cell(x, y)
    grid[x][y]
  end

  def reveal_ships
    board = "- 1 2 3 4 5 6 7 8 9 10\n"
    letter = 'A'
    grid.each do |row|
      board << letter + row.collect { |cell| cell.ship? ? ' X' : '  ' }.join('') + "\n"
      letter.next!
    end
    board
  end

  def to_s
    board = "- 1 2 3 4 5 6 7 8 9 10\n"
    letter = 'A'
    grid.each do |row|
      line = row.collect do |cell|
        case cell.status
          when :hit
            ' X'
          when :missed
            ' -'
          else
            ' .'
        end
      end.join('')
      board << letter + line + "\n"
      letter.next!
    end
    board
  end

  private

  def select_cells(length)
    cells = []
    case [:horizontal, :vertical].sample
      when :horizontal
        start_position_x, start_position_y = (0...BOARD_SIZE-length).to_a.sample, (0...BOARD_SIZE).to_a.sample
        length.times do |index|
          cells << grid[start_position_x+index][start_position_y]
        end
      when :vertical
        start_position_x, start_position_y = (0...BOARD_SIZE).to_a.sample, (0...BOARD_SIZE-length).to_a.sample
        length.times do |index|
          cells << grid[start_position_x][start_position_y+index]
        end
    end
    cells
  end

  def overlapped?(fields)
    fields.any? { |cell| cell.occupied? }
  end
end
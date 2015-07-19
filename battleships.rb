require './board'
require './ship'

class Battleships

  attr_reader :board

  def initialize(board)
    @board = board
  end

  def play
    loop do
      puts 'Enter coordinates (row, col)'
      input = gets.chomp.strip
      if input == 'show'
        reveal_ships
        next
      end

      unless valid_input?(input)
        puts "Invalid input. Try again ..."
        next
      end
      break if player_turn(input)
    end
  end

  def reveal_ships
    puts board.reveal_ships
  end

  def player_turn(input)
    x, y = x_input(input[0]), y_input(input[1..-1])
    cell = board.cell(x, y)
    if cell.ship?
      cell.update :hit
      message = "Hit"
      message << " and sunk" if cell.ship.sunk?
    else
      cell.update :missed
      message = "Miss"
    end
    puts message
    puts board
    if finished?
      puts "Well done! You completed the game in #{attempts} shots"
      return true
    end
    false
  end

  private

  def x_input(input)
    ('A'..'J').to_a.find_index(input)
  end

  def y_input(input)
    input.to_i - 1
  end

  def finished?
    board.grid.flatten.all? { |cell| cell.status != :occupied }
  end

  def attempts
    board.grid.flatten.select { |cell| [:hit, :missed].include? cell.status }.size
  end

  def valid_input?(input)
    input =~ /^[A-J]{1}([1-9]{1}|10)$/
  end
end
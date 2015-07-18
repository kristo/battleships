require './battleships'

board = Board.new
battleship = Ship.new(5)
board.place(battleship)
destroyer1 = Ship.new(4)
board.place(destroyer1)
destroyer2 = Ship.new(4)
board.place(destroyer2)

main = Battleships.new(board)
main.play

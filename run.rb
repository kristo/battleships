require './battleships'

board = Board.new
board.place(Ship.new(5))
board.place(Ship.new(4))
board.place(Ship.new(4))

main = Battleships.new(board)
main.play

require './cell'

class Ship

  attr_accessor :squares

  def initialize(squares)
    @squares = squares
  end

  def sunk?
    @squares == 0
  end
end
class Cell

  attr_accessor :status, :ship

  def initialize
    @status = :free
    @ship = nil
  end

  def ship?
    !!@ship
  end

  def update(status)
    self.status = status
    self.ship.squares -= 1 if status == :hit
  end
end
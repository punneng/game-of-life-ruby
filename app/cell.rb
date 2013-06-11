class Cell
  class << self
    def dead
      new(false)
    end

    def live
      new(true)
    end
  end

  def initialize(live=false)
    @live = live
  end

  def alive?
    @live
  end

  def next_state(neighbors)
    obj = self
    count = neighbors.inject(0) { |sum, cell| sum += 1 if cell.alive?; sum }
    if alive?
      (count != 2) && (count != 3) ? kill : self
    else
      count == 3 ? resurrect : self
    end
  end

  protected

  def kill
    Cell.dead
  end

  def resurrect
    Cell.live
  end
end
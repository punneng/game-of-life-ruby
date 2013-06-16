class Cell
  BORN_RULES = {
    true:   Proc.new { Cell.live },
    false:  Proc.new { Cell.dead }
  }

  RULES = { 
    true:   Proc.new { |count| BORN_RULES[[2,3].include?(count).to_s.to_sym].call },
    false:  Proc.new { |count| BORN_RULES[count.eql?(3).to_s.to_sym].call }
  }

  class << self
    def dead
      new(false)
    end

    def live
      new(true)
    end
  end

  def initialize(state=false)
    @state = state
  end

  def alive?
    @state
  end

  def next_state(neighbors)
    count = neighbors.inject(0) { |sum ,neighbor| neighbor.alive? and sum += 1; sum }
    RULES[self.alive?.to_s.to_sym].call(count)
  end
end
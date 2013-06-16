class Cell
  SUB_ROLES = {
    true:   Proc.new { Cell.live },
    false:  Proc.new { Cell.dead }
  }

  ROLES = { 
    true:   Proc.new { |count| SUB_ROLES[[2,3].include?(count).to_s.to_sym].call },
    false:  Proc.new { |count| SUB_ROLES[count.eql?(3).to_s.to_sym].call }
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
    ROLES[self.alive?.to_s.to_sym].call(count)
  end
end
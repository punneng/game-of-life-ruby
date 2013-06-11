class Game
  class << self
    RENDER_TPYES = {
      binary:   Proc.new { |elem| elem.alive? ? 1 : 0 },
      object:   Proc.new { |elem| elem.zero? ? Cell.dead : Cell.live },
      graphic:  Proc.new { |elem| elem.zero? ? ' ' : 'x' }
    }

    def render_grid(type, tiles)
      result= []
      block = RENDER_TPYES.fetch(type, nil)

      return result unless block

      tiles.each do |line|
        line_stack = line.map &block
        result.push line_stack
      end
      result
    end

    def fetch(tiles)
      grid = render_grid(:object, tiles)
      rendered_grid = Array.new(grid.size) { Array.new(grid[0].size) }
      grid.each_with_index do |line, l|
        line.each_with_index do |elem, e|
          neigbors = []
          [-1,0,1].each do |y|
            [-1,0,1].each do |x|
              # NOTE: this spagetti code can be split to a new function
              #       and testable
              next if (x == 0) && (y == 0)
              py = l + y
              px = e + x
              next if (px < 0 ) || (py < 0)
              next if (px > (line.size-1)) || (py > (grid.size-1))
              neigbors << grid[py][px]
            end
          end
          rendered_grid[l][e] = elem.next_state(neigbors)
        end
      end
      render_grid(:binary, rendered_grid)
    end

    def start(grid, repeat=30, delay=1)
      (1..repeat).each do |i|
        grid = fetch(grid)
        render_grid(:graphic, grid).each { |line| puts line.to_s }
        puts " "
        sleep delay
      end
    end
  end
end

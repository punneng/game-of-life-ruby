require 'spec_helper'

describe Cell do
  context 'when initializing with blank args' do
    let!(:cell) { Cell.new }
    it 'should be dead' do
      expect(cell).not_to be_alive
    end
  end

  describe '#dead' do
    it 'initializes dead cell' do
      expect(Cell.dead).not_to be_alive
    end
  end

  describe '#live' do
    it 'initializes live cell' do
      expect(Cell.live).to be_alive
    end
  end

  describe '#next_state' do
    context 'when live' do
      let!(:cell) { Cell.live }
      let(:neighbours) { Game.render_grid(:object, grid) }

      context 'with fewer than two live neighbours' do
        let!(:grid) do
          [ 
            [0,0,1],
            [0,  0], # the middle is skipped as a subject
            [0,0,0],
          ]
        end
        
        it 'returns a dead cell' do
          expect(cell.next_state(neighbours.flatten)).not_to be_alive
        end
      end

      context 'with two or three live neighbours' do
        let!(:two_neighbor_grid) do
          [ 
            [0,0,1],
            [0,  0], # the middle is skipped as a subject
            [0,1,0],
          ]
        end
        let!(:three_neighbor_grid) do
          [ 
            [0,0,1],
            [0,  1],
            [0,1,0],
          ]
        end
        let!(:two_neighbors) { Game.render_grid(:object, two_neighbor_grid) }
        let!(:three_neighbors) { Game.render_grid(:object, three_neighbor_grid) }

        it 'lives' do
          cell.next_state(two_neighbors.flatten)
          expect(cell).to be_alive

          cell = Cell.live
          cell.next_state(three_neighbors.flatten)
          expect(cell).to be_alive
        end
      end

      context 'with more than three live neighbours' do
        let!(:grid) do
          [ 
            [1,0,1],
            [0,  1],
            [1,0,0],
          ]
        end

        it 'returns a dead cell' do
          expect(cell.next_state(neighbours.flatten)).not_to be_alive
        end
      end
    end

    context 'when dead' do
      let!(:cell) { Cell.dead }
      let!(:neighbours) { Game.render_grid(:object, grid) }

      context 'with exactly three live neighbours' do
        let!(:grid) do
          [ 
            [1,0,1],
            [0,  0],
            [1,0,0],
          ]
        end
        
        it 'returns live cell' do
          expect(cell.next_state(neighbours.flatten)).to be_alive
        end
      end
    end
  end
end
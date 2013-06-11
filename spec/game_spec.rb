require 'spec_helper'

describe Game do
  describe '#fetch' do
    context %q{ when input  
                [0,0,0,0],
                [0,1,1,0],
                [0,1,1,0],
                [0,0,0,0] 
    } do
      it %q{ should be  
          [0,0,0,0],
          [0,1,1,0],
          [0,1,1,0],
          [0,0,0,0] 
      } do
        tile = { input: [
                    [0,0,0,0],
                    [0,1,1,0],
                    [0,1,1,0],
                    [0,0,0,0]
                  ],
                  output: [
                    [0,0,0,0],
                    [0,1,1,0],
                    [0,1,1,0],
                    [0,0,0,0]
                  ]
                }

        expect(Game.fetch(tile[:input])).to eql(tile[:output])
      end
    end

    context %q{ when input 
      [0,0,0,0,0],
      [0,0,0,0,0],
      [0,1,1,1,0],
      [0,0,0,0,0],
      [0,0,0,0,0] } do
      it %q{ should be
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,0,1,0,0],
        [0,0,1,0,0],
        [0,0,0,0,0]
      } do
        tile = { input: [
            [0,0,0,0,0],
            [0,0,0,0,0],
            [0,1,1,1,0],
            [0,0,0,0,0],
            [0,0,0,0,0]
          ],
          output: [
            [0,0,0,0,0],
            [0,0,1,0,0],
            [0,0,1,0,0],
            [0,0,1,0,0],
            [0,0,0,0,0]
          ]
        }

        expect(Game.fetch(tile[:input])).to eql(tile[:output])
      end
    end
  end

  describe '#render_grid' do
    let!(:dead_cell) { Cell.dead }
    let!(:live_cell) { Cell.live }

    before :each do
      Cell.stub(:dead).and_return(dead_cell)
      Cell.stub(:live).and_return(live_cell)
    end

    context 'object' do
      let!(:tile) do 
        { input:  [ 
                    [0,0,1],
                    [0,  0],
                    [0,1,0]
                  ],
          output: [
                    [dead_cell, dead_cell, live_cell],
                    [dead_cell,            dead_cell],
                    [dead_cell, live_cell, dead_cell]
                  ]
        }
      end

      it 'returns a list of object array' do
        expect(Game.render_grid(:object, tile[:input])).to eq(tile[:output])
      end
    end

    describe 'binary' do
      let!(:tile) do 
        { input:  [ 
                    [dead_cell, dead_cell, live_cell],
                    [dead_cell,            dead_cell],
                    [dead_cell, live_cell, dead_cell]
                  ],
          output: [
                    [0,0,1],
                    [0,  0],
                    [0,1,0]
                  ]
        }
      end

      it 'returns a list of binary array' do
        expect(Game.render_grid(:binary, tile[:input])).to eq(tile[:output])
      end
    end

    describe 'graphic' do
      let!(:tile) do 
        { input:  [ 
                    [0,0,1],
                    [0,0,1],
                    [0,1,0]
                  ],
          output: [
                    [' ',' ','x'],
                    [' ',' ','x'],
                    [' ','x',' ']
                  ]
        }
      end

      it 'returns a list of graphic array' do
        expect(Game.render_grid(:graphic, tile[:input])).to eq(tile[:output])
      end
    end
  end

  describe '#start' do
    let!(:tile) do 
      { input:  [ 
                  [0,0,0,0,0],
                  [0,0,0,0,0],
                  [0,1,1,1,0],
                  [0,0,0,0,0],
                  [0,0,0,0,0] 
                ],
        output: %q{[" ", " ", " ", " ", " "]
[" ", " ", "x", " ", " "]
[" ", " ", "x", " ", " "]
[" ", " ", "x", " ", " "]
[" ", " ", " ", " ", " "]}
      }
    end

    it 'should render graphic display' do
      repeat = 2
      output = capture_stdout { Game.start(tile[:input], repeat) }
      expect(output).to include(tile[:output].to_s)
    end
  end
end
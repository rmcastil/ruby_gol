require_relative 'gol'

describe 'Cell' do
  context '#neighbors' do
    it 'returns 0 if a cell has no neighbors' do
      cell = Cell.new Location.new(2,1)
      cell.neighbors.count.should == 0
    end
  end

  context '#location' do
    it "returns a cell's Location" do
      cell = Cell.new Location.new(1,2)
      cell.location.y.should == 2
    end
  end
end

describe 'Location' do
  it 'can hold x, y coordinates' do
    loc = Location.new(0,100)

    loc.x.should == 0
  end

  it 'returns true if two locations share x, y coordinates' do
    loc = Location.new(0,100)

    (Location.new(0,100) == loc).should == true
  end

  it 'returns false if two locations do not share x, y coordinates' do
    (Location.new(0,100) == Location.new(1,100)).should == false
  end
end

describe 'Board' do
  context '#add_cell' do
    it 'can add cells to the board' do
      board = Board.new
      cell = Cell.new Location.new(1,2)
      board.add_cell(cell)

      board.cells.should == [cell]
    end
  end

  context '#tick!' do
    it 'can proceed to the next generation via a tick' do
      board = Board.new
      board.tick!

      board.generation.should == 1
    end
  end
end

describe 'GoL' do
  context 'Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do
    it 'a cell dies after one tick since it has 0 neighbors' do
      cell = Cell.new Location.new(1,1)
      board = Board.new
      board.add_cell(cell)
      board.tick!

      board.is_alive?(Location.new(1,1)).should == false
    end

    it 'a cell dies after one tick since it only has one neighbor' do
      cell = Cell.new(Location.new(0,0))
      adjacent_cell = Cell.new(Location.new(1,0))
      board = Board.new
      board.add_cell(cell)
      board.add_cell(adjacent_cell)
      board.tick!

      board.is_alive?(Location.new(0,0)).should == false
    end
  end

  context 'Any live cell with two or three live neighbours lives on to the next generation.' do
    before do
      cell = Cell.new(Location.new(0,0))
      adjacent_cell = Cell.new(Location.new(1,0))
      another_adjacent_cell = Cell.new(Location.new(0,1))
      @board = Board.new
      @board.add_cell(cell)
      @board.add_cell(adjacent_cell)
      @board.add_cell(another_adjacent_cell)
    end

    it 'a cell is alive after one tick since it has two neighbors' do
      @board.is_alive?(Location.new(0,0)).should == true
    end

    it 'a cell is alive after one tick since it has three neighbors' do
      one_more_adjacent_cell = Cell.new(Location.new(1,1))
      @board.add_cell(one_more_adjacent_cell)

      @board.is_alive?(Location.new(0,0)).should == true
    end
  end
end

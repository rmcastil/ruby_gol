require_relative 'gol'

describe 'Cell' do
  context '#neighbors_count' do
    it 'returns 0 if a cell has no neighbors' do
      cell = Cell.new(Location.new(2,1), Board.new)
      cell.neighbors_count.should == 0
    end

    it 'returns 1 if cell has one neighbor' do
      board = Board.new
      cell = Cell.new(Location.new(0,0), board)
      neighbor_cell = Cell.new(Location.new(1,0), board)

      cell.neighbors_count.should == 1
    end

    it 'returns 2 if cell has two neighbors' do
      board = Board.new
      cell = Cell.new(Location.new(0,0), board)
      north_west_cell = Cell.new(Location.new(-1, 1), board)
      north_cell = Cell.new(Location.new(0, 1), board)

      cell.neighbors_count.should == 2
    end

    it 'returns 3 if a cell has 3 neighbors' do
      board = Board.new
      cell = Cell.new(Location.new(0,0), board)
      south_west_cell = Cell.new(Location.new(-1, -1), board)
      south_cell = Cell.new(Location.new(0, -1), board)
      north_east_cell = Cell.new(Location.new(1, 1), board)

      cell.neighbors_count.should == 3
    end
  end

  context '#location' do
    it "returns a cell's Location" do
      cell = Cell.new(Location.new(1,2), Board.new)
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
      board = Board.new
      cell = Cell.new(Location.new(1,1), board)
      board.tick!

      board.is_alive?(Location.new(1,1)).should == false
    end

    it 'a cell dies after one tick since it only has one neighbor' do
      board = Board.new
      cell = Cell.new(Location.new(0,0), board)
      adjacent_cell = Cell.new(Location.new(1,0), board)
      board.tick!

      board.is_alive?(Location.new(0,0)).should == false
    end
  end

  context 'Any live cell with two or three live neighbours lives on to the next generation.' do
    before do
      @board = Board.new
      cell = Cell.new(Location.new(0,0), @board)
      adjacent_cell = Cell.new(Location.new(1,0), @board)
      another_adjacent_cell = Cell.new(Location.new(0,1), @board)
    end

    it 'a cell is alive after one tick since it has two neighbors' do
      @board.is_alive?(Location.new(0,0)).should == true
    end

    it 'a cell is alive after one tick since it has three neighbors' do
      one_more_adjacent_cell = Cell.new(Location.new(1,1), @board)

      @board.is_alive?(Location.new(0,0)).should == true
    end
  end
end

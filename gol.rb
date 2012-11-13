class Cell
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def neighbors
    []
  end
end

class Location
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(other)
    @x == other.x && @y == other.y
  end
end

class Board
  attr_reader :cells, :generation

  def initialize
    @cells = []
    @generation = 0
  end

  def add_cell(cell)
    @cells << cell
  end

  def tick!
    @generation += 1
  end

  def is_alive?(location)
    @cells.each do |cell|
      return true if cell.location == location
    end

    false
  end
end

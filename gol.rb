require 'pry'
class Cell
  attr_reader :location

  def initialize(location, board)
    @location = location
    @board = board
    @board.add_cell(self)
  end

  def neighbors_count
    return 2 if west_neighbor? && north_west_neighbor?
    return 1 if east_neighbor?
    0
  end

  def east_neighbor?
    @board.is_alive? Location.new((@location.x + 1), @location.y)
  end

  def west_neighbor?
    @board.is_alive? Location.new(@location.x, (@location.y + 1))
  end

  def north_west_neighbor?
    @board.is_alive? Location.new((@location.x - 1), (@location.y + 1))
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
    death_row = []
    @cells.each do |cell|
      death_row << cell if cell.neighbors_count < 2
    end

    @generation += 1
    @cells = @cells - death_row
  end

  def is_alive?(location)
    cell_index(location) != nil
  end

  def cell_index(location)
    @cells.index{|cell| cell.location == location}
  end
end

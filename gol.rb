require 'pry'
class Cell
  attr_reader :location

  def initialize(location, board)
    @location = location
    @board = board
    @board.add_cell(self)
  end

  def neighbors_count
    neighbors = []
    offsets = [-1, 0, 1]
    offsets.each do |x_offset|
      offsets.each do |y_offset|
        x = @location.x + x_offset
        y = @location.y + y_offset

        unless x_offset == 0 && y_offset == 0
          neighbors << (@board.is_alive? Location.new(x, y))
        end
      end
    end

    neighbors.count(true)
  end

  def overcrowded?
    neighbors_count > 3
  end

  def under_populated?
    neighbors_count < 2
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
      if cell.under_populated? || cell.overcrowded?
        death_row << cell
      end
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

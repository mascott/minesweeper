require 'tile'

class Board
  SIZE = 3

  attr_reader :flag_count

  def initialize(mine_count: 0, tile_class: Tile)
    @tile_class = tile_class
    @mine_count = mine_count
    @flag_count = mine_count
  end

  def to_s
    grid.map{ |row| row.map(&:to_s).join(" ") }.join("\n")
  end

  def click!(x:, y:)
    value = reveal(x: x, y: y)

    return "SHIT JUST GOT REAL" if value == -1
    return value if value > 0

    reveal_adjacent(x, y)
  end

  def flag!(x:, y:)
    return false if adding_flag_when_none_left?(grid[x][y])

    grid[x][y].flag! ? @flag_count -= 1 : @flag_count += 1
  end

  def grid
    @grid ||= Array.new(SIZE) { Array.new(SIZE) { @tile_class.new } }
  end

  private

  def adding_flag_when_none_left?(grid_location)
    grid_location.flaggable? && flag_count <= 0
  end

  def reveal(x:, y:)
    raise "Nope" unless x >= 0 && y >= 0

    grid[x][y].reveal
  end

  def reveal_adjacent(x, y)
    [-1, 0, 1].each do |x_modifier|
      [-1, 0, 1].each do |y_modifier|

        x_location = x+x_modifier
        y_location = y+y_modifier

        next unless (0...SIZE).include?(x_location) && (0...SIZE).include?(y_location)

        value = reveal(x: x + x_modifier, y: y + y_modifier)

        # TODO: MAKE THIS RECURSIVE
      end
    end
  end
end

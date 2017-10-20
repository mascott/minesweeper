class Tile
  attr_reader :value
  FLAG = "?"
  HIDDEN = "_"
  EMPTY = " "

  def initialize()
    @revealed = false
    @flagged = false
    @value = 0
  end

  def revealed?
    @revealed
  end

  def reveal
    @revealed = true
    @value
  end

  def flagged?
    @flagged
  end

  def flaggable?
    !flagged?
  end

  def flag!
    @flagged = !@flagged
  end

  def increment
    @value += 1
  end

  def to_s
    if flagged?
      FLAG
    elsif revealed?
      value == 0 ? EMPTY : value
    else
      HIDDEN
    end
  end
end

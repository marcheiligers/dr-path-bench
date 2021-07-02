class PathTile
  attr_reader :x, :y, :hash

  def initialize(x, y)
    @x = x
    @y = y
  end

  def dist(target_x, target_y)
    @dist ||= (target_x - x).abs + (target_y - y).abs
  end

  def hash
    @hash ||= x << 16 + y
  end

  def eql?(other)
    hash == other.hash
  end
end
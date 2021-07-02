class PathTile
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def dist(target_x, target_y)
    @dist ||= (target_x - x).abs + (target_y - y).abs
  end
end
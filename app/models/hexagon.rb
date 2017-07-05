class Hexagon
  def self.points(start, length)
    a = Math.sin(30 * Math::PI / 180) * length
    b = Math.sin(120 * Math::PI / 180) * length
    x, y = start[0], start[1]
    points = "#{x.round(4)},#{y.round(4)}"
    x -= a
    y += b
    points += " #{x.round(4)},#{y.round(4)}"
    x += a
    y += b
    points += " #{x.round(4)},#{y.round(4)}"
    x += length
    y = y
    points += " #{x.round(4)},#{y.round(4)}"
    x += a
    y -= b
    points += " #{x.round(4)},#{y.round(4)}"
    x -= a
    y -= b
    points += " #{x.round(4)},#{y.round(4)}"
  end

  def self.center(start, length)
    b = Math.sin(120 * Math::PI / 180) * length
    x = start[0] + length / 2
    y = start[1] + b
    [x.round(4), y.round(4)]
  end

  def self.rotation(start, length)
    center = Hexagon.center(start, length)
    "rotate(15, #{center[0]},#{center[1]})"
  end
end
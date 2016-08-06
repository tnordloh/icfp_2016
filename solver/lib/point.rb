class Point
  def initialize(x, y)
    @x = x.to_r
    @y = y.to_r
  end

  attr_reader :x, :y

  def +(other)
    Point.new(x + other.x, y + other.y)
  end

  def -(other)
    Point.new(x - other.x, y - other.y)
  end

  def /(n)
    Point.new(x / n, y / n)
  end

  def rotate(degrees, around: Point([0, 0]))
    radians = degrees * Math::PI / 180

    s = Math.sin(radians)
    c = Math.cos(radians)

    offset = self - around

    rotated = self.class.new(
      (offset.x * c - offset.y * s).round(6),
      (offset.x * s + offset.y * c).round(6)
    )

    rotated + around
  end

  def ==(other)
    self.class == other.class && x == other.x && y == other.y
  end

  def to_s
    "#{simplify x},#{simplify y}"
  end

  private

  def simplify(fraction)
    if fraction.denominator == 1
      fraction.numerator
    else
      fraction
    end
  end
end

def Point(vertex)
  case vertex
  when Point
    vertex
  when Array
    Point.new(*vertex)
  else
    fail "Invalid point"
  end
end

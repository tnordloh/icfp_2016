class Point
  def initialize(x, y)
    if x.to_s.size > 15 || y.to_s.size > 15
      simplified = Rational(x.to_i / y.to_f)
      @x = simplified.numerator
      @y = simplified.denominator
    else
      @x = x.to_r
      @y = y.to_r
    end
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

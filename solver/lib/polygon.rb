require_relative "point"

class Polygon
  def initialize(vertices)
    @vertices = vertices.map { |vertex| Point(vertex) }
  end

  attr_reader :vertices

  def clockwise?
    (vertices + [vertices.first])
      .each_cons(2)
      .inject(0) { |curve, (start, finish)|
        curve + ((finish.x - start.x) * (finish.y + start.y))
      } >= 0
  end

  def counter_clockwise?
    !clockwise?
  end

  def centroid
    vertices.inject(:+) / vertices.size
  end

  def translate(translation)
    move = Point(translation)
    self.class.new(vertices.map { |vertex| vertex + move })
  end

  def overlay(other)
    translation = other.centroid - centroid
    translate(translation)
  end

  def ==(other)
    offset = other.vertices.index(vertices.first)
    vertices == other.vertices.rotate(offset)
  end
end

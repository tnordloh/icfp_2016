require_relative "point"

class BoundingBox
  def initialize(vertices)
    @lowest_x = vertices.map(&:x).min
    @highest_x = vertices.map(&:x).max
    @lowest_y = vertices.map(&:y).min
    @highest_y = vertices.map(&:y).max
  end

  attr_reader :lowest_x, :highest_x, :lowest_y, :highest_y

  def width
    highest_x - lowest_x
  end

  def height
    highest_y - lowest_y
  end

  def centroid
    Point([lowest_x + width / 2, lowest_y + height / 2])
  end
end

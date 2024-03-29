require "minitest/autorun"
require "minitest/pride"

require "polygon"

describe Polygon do
  it "can determine the centroid" do
    square = Polygon.new([[0, 0], [1, 0], [1, 1], [0, 1]])
    square.centroid.must_equal(Point.new(1/2r, 1/2r))
  end

  it "can translate all vertices" do
    triangle = Polygon.new([[0, 0], [1, 0], [0, 2]])
    triangle.translate([1, 1/2r]).must_equal(
      Polygon.new([[1, 1/2r], [2, 1/2r], [1, 5/2r]])
    )
  end

  it "can overlay on another polygon" do
    source = Polygon.new([[0, 0], [1, 0], [0, 1]])
    destination = Polygon.new([[1, 1], [2, 1], [1, 2]])
    source.overlay(destination).must_equal(destination)
  end

  it "knows if a polygon is clockwise" do
    counter_clockwise = Polygon.new([[0, 0], [1, 0], [1, 1], [0, 1]])
    clockwise = Polygon.new([[0, 0], [0, 1], [1, 1], [1, 0]])
    counter_clockwise.clockwise?.must_equal(false)
    counter_clockwise.counter_clockwise?.must_equal(true)
    clockwise.clockwise?.must_equal(true)
    clockwise.counter_clockwise?.must_equal(false)
  end
end

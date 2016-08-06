require "minitest/autorun"

require "point"

describe Point do
  it "can rotate a point around the origin" do
    point = Point([1, 0])
    point.rotate(90).must_equal(Point([0, 1]))
  end
end

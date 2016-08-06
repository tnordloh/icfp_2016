class Figure
  def initialize(polygons)
    @polygons = polygons
  end

  attr_reader :polygons
  private     :polygons

  def centroid
    polygons.flat_map(&:vertices).inject(:+) /
      polygons.map { |polygon| polygon.vertices.size }.inject(:+)
  end
end

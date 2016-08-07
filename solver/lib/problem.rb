require_relative "bounding_box"
require_relative "magic_shrinking_paper"
require_relative "polygon"
require_relative "solution"

class Problem
  def initialize(number, path)
    @number = number
    @polygons = [ ]

    parse(path)
  end

  attr_reader :number, :polygons
  private     :number, :polygons

  def solve
    paper = MagicShrinkingPaper.new
    box = BoundingBox.new(
      polygons.select(&:counter_clockwise?).flat_map(&:vertices)
    )
    paper.shrink(width: [box.width, 1].min, height: [box.height, 1].min)
    paper.center(box.centroid)
    Solution.new(number, paper).write
  end

  private

  def parse(path)
    open(path) do |f|
      polygon_count = Integer(f.gets)

      polygon_count.times do
        vertices_count = Integer(f.gets)

        vertices =
          f
            .take(vertices_count)
            .map { |line| line.split(",").map(&:to_r) }
        polygons << Polygon.new(vertices)
      end
    end
  end
end

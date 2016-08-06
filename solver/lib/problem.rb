require_relative "figure"
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
    paper = Polygon.new([[0, 0], [1, 0], [1, 1], [0, 1]])
    figure = Figure.new(polygons.select(&:counter_clockwise?))
    solution = paper.overlay(figure)
    Solution.new(number, paper, solution).write
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

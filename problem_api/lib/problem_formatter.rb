require 'json'
class ProblemFormatter
  def initialize(problem_number)
    build_hash(problem_number)
  end

  def json
    @hash.to_json
  end

  private

  def build_hash(filename)
    lines_array = File.read("../../problems/#{filename}.txt").split(/\n/)
    @hash = {
      "polygons" => build_polygons(lines_array),
      "lines"    => build_lines(lines_array)
    }
  end

  def build_polygons(lines_array)
    count = lines_array.shift.to_i
    polygons = []
    count.times do
      vertices_amount = lines_array.shift.to_i
      vertices = lines_array.shift(vertices_amount)
      polygons << { "negative" => false,
                    "vertices" => vertices
      }
    end
    polygons
  end

  def build_lines(array)
    array[1..-1].map { |string| string.split(' ').map { |xy| xy.split(',')} }
  end
end

puts ProblemFormatter.new(100).json

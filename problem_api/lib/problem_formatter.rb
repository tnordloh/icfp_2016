require 'json'
class ProblemFormatter
  def initialize(problem_number)
    lines_array = File.read("../../problems/#{problem_number}.txt").split(/\n/)
    polygons_count = lines_array.shift.to_i
    @hash = {
      "polygons" => build_polygons(polygons_count, lines_array),
      "lines"    => build_lines(lines_array)
    }
  end

  def json
    @hash.to_json
  end

  private

  def build_polygons(count, lines_array)
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

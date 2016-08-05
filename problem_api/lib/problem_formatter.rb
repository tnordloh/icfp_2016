require 'json'
class ProblemFormatter
  def initialize(problem_number)
    @filename = "#{problem_number}.txt"
  end

  attr_reader :filename

  def json
    @json ||= build_hash(filename).to_json
  end

  private

  def build_hash(filename)
    lines_array = File.read(
      File.expand_path("../../../problems/#{filename}", __FILE__)
    ).split(/\n/)
    {
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
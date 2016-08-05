require 'json'

class SolutionFormatter
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
      File.expand_path("../../../solutions/#{filename}", __FILE__)
    ).split(/\n/)
    {
      "polygons" => build_polygons(lines_array)
    }
  end

  def build_polygons(lines_array)
    coordinates  = grab_chunk(lines_array)
    polygon_list = lines_array.drop(lines_array[0].to_i + 1)
    moves        = grab_chunk(polygon_list)
    p coordinates
    p lines_array
    p polygon_list
    p moves
  end

  def grab_chunk(array)
    array.slice(1, array[0].to_i)
  end
end

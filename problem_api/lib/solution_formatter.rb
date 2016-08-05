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
    coordinates  = grab_chunk(lines_array).map do |pair|
      pair.split(',').map do |num|
        Rationalizer.new(num).run
      end
    end
    remaining_list = lines_array.drop(lines_array[0].to_i + 1)
    moves          = grab_chunk(remaining_list)
    moves.map do |numbers_string|
        numbers_string
        .split(' ')
        .drop(1)
        .map(&:to_i)
        .map { |int| build_step(int, coordinates) }
    end
  end

  def build_step(int, coords)
    {
      'x' => {
        'numerator' => coords[int][0][0],
        'denomenator' => coords[int][0][1]
      },
      'y' => {
        'numerator' => coords[int][1][0],
        'denomenator' => coords[int][1][1]
      }
    }
  end

  def grab_chunk(array)
    array.slice(1, array[0].to_i)
  end
end

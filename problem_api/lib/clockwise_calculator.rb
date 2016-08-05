require_relative 'rationalizer'

class ClockwiseCalculator
  def initialize(vertices_array)
    @vertices = format(vertices_array)
  end

  attr_reader :vertices

  def clockwise?
    runner >= 0
  end

  def counter_clockwise?
    !clockwise?
  end

  private

  def format(array)
    array.map do |pair|
      pair.split(',').map { |unit| Rationalizer.new(unit).run }
    end
  end

  def runner
    acc = 0
    @vertices.length.times do
      acc += (divide(@vertices[1][0]) - divide(@vertices[0][0])) *
             (divide(@vertices[1][1]) + divide(@vertices[0][1]))
      @vertices.rotate!
    end
    acc
  end

  def divide(num_array)
    num_array.first.to_f / num_array.last
  end
end

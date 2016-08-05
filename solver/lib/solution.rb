class Solution
  def initialize(number, source, destination)
    @number = number
    @source = source
    @destination = destination
  end

  attr_reader :number, :source, :destination
  private     :number, :source, :destination

  def write
    path = File.join(__dir__, *%W[.. .. solutions #{number}.txt])
    open(path, "w") do |f|
      f.puts source.vertices.size
      source.vertices.each do |vertex|
        f.puts vertex
      end

      # FIXME
      f.puts 1
      f.puts "4 0 1 2 3"

      destination.vertices.each do |vertex|
        f.puts vertex
      end
    end
    path
  end
end

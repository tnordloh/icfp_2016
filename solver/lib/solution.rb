class Solution
  def initialize(number, paper)
    @number = number
    @paper = paper
  end

  attr_reader :number, :paper
  private     :number, :paper

  def write
    path = File.join(__dir__, *%W[.. .. solutions #{number}.txt])
    open(path, "w") do |f|
      f.puts paper
    end
    path
  end
end

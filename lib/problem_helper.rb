class ProblemHelper
  def initialize
    @points = []
    @destinations = [] 
    @polygons = Array.new
  end

  def add_vertex(point,destination)
    @points << point
    @destinations << destination
  end

  def add_polygon(polygon)
    @polygons << polygon.split(" ")
  end

  def to_s
    @points.size.to_s + "\n" +
      @points.map {|p| p.join(',')}.join("\n") + "\n" +
      @polygons.size.to_s + "\n" +
      @polygons.map {|p| "#{p.size} #{p.join(" ")}"}.join("\n") + "\n" +
      @destinations.map {|p| p.join(',')}.join("\n") + "\n"
  end
end


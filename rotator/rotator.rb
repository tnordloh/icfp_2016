class Rotator
  def self.rotate(cx, cy, angle, point)
    rad_angle = angle * Math::PI / 180
    s = Math.sin(rad_angle).to_r
    c = Math.cos(rad_angle).to_r

    #translate point back to origin
    point.x -= cx.to_r
    point.y -= cy.to_r

    # rotate point
    xnew = (point.x * c - point.y * s)
    ynew = (point.x * s + point.y * c)

    # translate back
    point.x = (xnew + cx.to_r).to_r
    point.y = (ynew + cy.to_r).to_r

    puts "#{point.x},#{point.y}"
  end
end

Point = Struct.new(:x, :y)
cx = ARGV.shift.to_r
cy = ARGV.shift.to_r
angle = ARGV.shift.to_r
p = Point.new
p.x = ARGV.shift.to_r
p.y = ARGV.shift.to_r

Rotator.rotate(cx, cy, angle, p)

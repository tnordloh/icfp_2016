class Rotator
  def self.rotate(cx, cy, angle, point)
    rad_angle = angle * Math::PI / 180
    s = Math.sin(rad_angle)
    c = Math.cos(rad_angle)

    #translate point back to origin
    point.x -= cx.to_f
    point.y -= cy.to_f

    # rotate point
    xnew = (point.x * c - point.y * s)
    ynew = (point.x * s + point.y * c)

    # translate back
    point.x = (xnew + cx.to_f).to_r
    point.y = (ynew + cy.to_f).to_r

    puts "#{point.x},#{point.y}"
  end
end

Point = Struct.new(:x, :y)
cx = ARGV.shift.to_f
cy = ARGV.shift.to_f
angle = ARGV.shift.to_f
p = Point.new
p.x = ARGV.shift.to_f
p.y = ARGV.shift.to_f

Rotator.rotate(cx, cy, angle, p)

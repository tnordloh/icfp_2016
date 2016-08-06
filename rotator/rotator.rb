class Rotator
  def self.rotate(cx, cy, angle, point)
    rad_angle = angle * Math::PI / 180
    s = Math.sin(rad_angle)
    c = Math.cos(rad_angle)

    #translate point back to origin
    point.x -= cx.to_f
    point.y -= cy.to_f

    # rotate point
    xnew = (point.x * c - point.y * s).round(6)
    ynew = (point.x * s + point.y * c).round(6)

    # translate back
    point.x = (xnew + cx.to_f).to_r
    point.y = (ynew + cy.to_f).to_r

    p point
  end
end

point = Struct.new(:x, :y)
p = point.new(1.0, 0.0)
Rotator.rotate(0.0, 0.0, 90, p)

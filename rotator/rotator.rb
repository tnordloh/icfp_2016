require_relative "../solver/lib/point"

abort "USAGE:  #{$PROGRAM_NAME} AROUND_X AROUND_Y DEGREES X Y" \
  unless ARGV.size == 5 && ARGV.all? { |n| n =~ /\A\d+/ }
around_x, around_y, angle, x, y = ARGV.map(&:to_f)

puts Point([x, y]).rotate(angle, around: Point([around_x, around_y]))

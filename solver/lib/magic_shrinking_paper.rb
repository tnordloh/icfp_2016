require_relative "point"

class MagicShrinkingPaper
  def initialize
    @width = 1
    @height = 1
    @centroid = Point([0, 0])
  end

  attr_reader :width, :height, :centroid

  def shrink(width: 1, height: 1)
    fail "Illegal width:  #{width}" unless width > 0 && width <= 1
    fail "Illegal height:  #{height}" unless height > 0 && height <= 1

    @width = width
    @horizontal_folds = nil
    @horizontal_fold_lines = nil
    @height = height
    @vertical_folds = nil
    @vertical_fold_lines = nil
    @vertices = nil
  end

  def center(point)
    @centroid = point - Point([width.to_r / 2, height.to_r / 2])
  end

  def horizontal_folds
    @horizontal_folds ||=
      begin
        horizontal_folds = 0
        factor = (1 - width).to_r
        half_width = 1/2r

        loop do
          break unless factor > 0

          horizontal_folds += 1
          factor -= half_width
          half_width /= 2
        end

        horizontal_folds
      end
  end

  def vertical_folds
    @vertical_folds ||=
      begin
        vertical_folds = 0
        factor = (1 - height).to_r
        half_height = 1/2r

        loop do
          break unless factor > 0

          vertical_folds += 1
          factor -= half_height
          half_height /= 2
        end

        vertical_folds
      end
  end

  def vertices
    @vertices ||=
      begin
        xs = [0, 1]
        horizontal_fold_lines.reverse_each do |fold|
          if xs.size == 2
            xs = [0, fold, 1]
          else
            distance = xs[1] - fold
            xs = xs.flat_map.with_index { |prev, i|
              i.odd? ? [prev - distance, prev, prev + distance] : [prev]
            }
          end
        end
        ys = [0, 1]
        vertical_fold_lines.reverse_each do |fold|
          if ys.size == 2
            ys = [0, fold, 1]
          else
            distance = ys[1] - fold
            ys = ys.flat_map.with_index { |prev, i|
              i.odd? ? [prev - distance, prev, prev + distance] : [prev]
            }
          end
        end
        ys.reverse.map { |y| xs.map { |x| Point([x, y]) } }
      end
  end

  def facets
    vertices
      .map
      .with_index { |row, y|
        row.each_index.map { |x| y * vertices.first.size + x }
      }
      .each_cons(2)
      .flat_map { |top, bottom|
        top
          .each_cons(2)
          .zip(bottom.each_cons(2).map(&:reverse))
          .flatten(1)
          .each_slice(2)
          .map(&:flatten)
      }
  end

  def destinations
    result = Marshal.load(Marshal.dump(vertices))

    horizontal_fold_lines.reverse_each do |fold|
      vertices.each_index do |y|
        vertices.first.each_index do |x|
          result[y][x] =
            if result[y][x].x > fold
              Point(
                [result[y][x].x - (result[y][x].x - fold) * 2, result[y][x].y]
              )
            else
              result[y][x]
            end
        end
      end
    end

    vertical_fold_lines.reverse_each do |fold|
      vertices.each_index do |y|
        vertices.first.each_index do |x|
          result[y][x] =
            if result[y][x].y > fold
              Point(
                [result[y][x].x, result[y][x].y - (result[y][x].y - fold) * 2]
              )
            else
              result[y][x]
            end
        end
      end
    end

    result.map { |row| row.map { |vertex| vertex + centroid } }
  end

  def to_s
    v = vertices
    f = facets
    [ v.inject(0) { |sum, row| sum + row.size },
      *v.flatten,
      f.size,
      *f.map { |facet| "#{facet.size} #{facet.join(' ')}" },
      *destinations.flatten ]
      .map { |line| "#{line}\n" }
      .join
  end

  private

  def horizontal_fold_lines
    @horizontal_fold_lines ||=
      Array.new(horizontal_folds) { |i|
        i.zero? ? width : "1/#{2 ** (horizontal_folds - i)}".to_r
      }
  end

  def vertical_fold_lines
    @vertical_fold_lines ||=
      Array.new(vertical_folds) { |i|
        i.zero? ? height : "1/#{2 ** (vertical_folds - i)}".to_r
      }
  end
end

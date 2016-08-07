require "minitest/autorun"

require "magic_shrinking_paper"

describe MagicShrinkingPaper do
  let(:paper) { MagicShrinkingPaper.new }

  it "doesn't use folds for size one" do
    paper.horizontal_folds.must_equal(0)
    paper.vertical_folds.must_equal(0)
  end

  it "folds to decrease width" do
    paper.shrink(width: 3/4r)
    paper.horizontal_folds.must_equal(1)

    paper.shrink(width: 1/2r)
    paper.horizontal_folds.must_equal(1)
  end

  it "uses multiple horizontal folds when needed" do
    paper.shrink(width: 1/3r)
    paper.horizontal_folds.must_equal(2)

    paper.shrink(width: 1/16r)
    paper.horizontal_folds.must_equal(4)
  end

  it "folds to decrease height" do
    paper.shrink(height: 3/4r)
    paper.vertical_folds.must_equal(1)

    paper.shrink(height: 1/2r)
    paper.vertical_folds.must_equal(1)
  end

  it "uses multiple vertical folds when needed" do
    paper.shrink(height: 1/3r)
    paper.vertical_folds.must_equal(2)

    paper.shrink(height: 1/16r)
    paper.vertical_folds.must_equal(4)
  end

  it "makes vertices for the fold" do
    paper.shrink(width: 1/8r, height: 1/8r)

    paper.vertices.must_equal(
      [
        [[0, 1],    [1/8r, 1],    [1/4r, 1],    [3/8r, 1],    [1/2r, 1],    [5/8r, 1],    [3/4r, 1],    [7/8r, 1],    [1, 1]],
        [[0, 7/8r], [1/8r, 7/8r], [1/4r, 7/8r], [3/8r, 7/8r], [1/2r, 7/8r], [5/8r, 7/8r], [3/4r, 7/8r], [7/8r, 7/8r], [1, 7/8r]],
        [[0, 3/4r], [1/8r, 3/4r], [1/4r, 3/4r], [3/8r, 3/4r], [1/2r, 3/4r], [5/8r, 3/4r], [3/4r, 3/4r], [7/8r, 3/4r], [1, 3/4r]],
        [[0, 5/8r], [1/8r, 5/8r], [1/4r, 5/8r], [3/8r, 5/8r], [1/2r, 5/8r], [5/8r, 5/8r], [3/4r, 5/8r], [7/8r, 5/8r], [1, 5/8r]],
        [[0, 1/2r], [1/8r, 1/2r], [1/4r, 1/2r], [3/8r, 1/2r], [1/2r, 1/2r], [5/8r, 1/2r], [3/4r, 1/2r], [7/8r, 1/2r], [1, 1/2r]],
        [[0, 3/8r], [1/8r, 3/8r], [1/4r, 3/8r], [3/8r, 3/8r], [1/2r, 3/8r], [5/8r, 3/8r], [3/4r, 3/8r], [7/8r, 3/8r], [1, 3/8r]],
        [[0, 1/4r], [1/8r, 1/4r], [1/4r, 1/4r], [3/8r, 1/4r], [1/2r, 1/4r], [5/8r, 1/4r], [3/4r, 1/4r], [7/8r, 1/4r], [1, 1/4r]],
        [[0, 1/8r], [1/8r, 1/8r], [1/4r, 1/8r], [3/8r, 1/8r], [1/2r, 1/8r], [5/8r, 1/8r], [3/4r, 1/8r], [7/8r, 1/8r], [1, 1/8r]],
        [[0, 0],    [1/8r, 0],    [1/4r, 0],    [3/8r, 0],    [1/2r, 0],    [5/8r, 0],    [3/4r, 0],    [7/8r, 0],    [1, 0]]
      ].map { |row| row.map { |vertex| Point(vertex) } }
    )
  end

  it "makes vertices for the fold with a single fold" do
    paper.shrink(width: 5/7r, height: 5/7r)

    paper.vertices.must_equal(
      [
        [[0, 1],    [5/7r, 1],    [1, 1]],
        [[0, 5/7r], [5/7r, 5/7r], [1, 5/7r]],
        [[0, 0],    [5/7r, 0],    [1, 0]]
      ].map { |row| row.map { |vertex| Point(vertex) } }
    )
  end

  it "solves problem 26" do
    paper.shrink(width: 3/8r, height: 3/8r)
    paper.to_s.must_equal(<<-END_SOLUTION.gsub(/^\s+/, ""))
    25
    0,1
    3/8,1
    1/2,1
    5/8,1
    1,1
    0,5/8
    3/8,5/8
    1/2,5/8
    5/8,5/8
    1,5/8
    0,1/2
    3/8,1/2
    1/2,1/2
    5/8,1/2
    1,1/2
    0,3/8
    3/8,3/8
    1/2,3/8
    5/8,3/8
    1,3/8
    0,0
    3/8,0
    1/2,0
    5/8,0
    1,0
    16
    4 0 1 6 5
    4 1 2 7 6
    4 2 3 8 7
    4 3 4 9 8
    4 5 6 11 10
    4 6 7 12 11
    4 7 8 13 12
    4 8 9 14 13
    4 10 11 16 15
    4 11 12 17 16
    4 12 13 18 17
    4 13 14 19 18
    4 15 16 21 20
    4 16 17 22 21
    4 17 18 23 22
    4 18 19 24 23
    0,0
    3/8,0
    1/4,0
    3/8,0
    0,0
    0,3/8
    3/8,3/8
    1/4,3/8
    3/8,3/8
    0,3/8
    0,1/4
    3/8,1/4
    1/4,1/4
    3/8,1/4
    0,1/4
    0,3/8
    3/8,3/8
    1/4,3/8
    3/8,3/8
    0,3/8
    0,0
    3/8,0
    1/4,0
    3/8,0
    0,0
    END_SOLUTION
  end
end

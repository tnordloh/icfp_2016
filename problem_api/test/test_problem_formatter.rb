require File.expand_path '../test_helper.rb', __FILE__
require 'json'

class ProblemFormatterTest < Minitest::Unit::TestCase

  def setup
    @formatter = ProblemFormatter.new(1)
  end

  def test_it_exposes_a_filename
    assert_equal '1.txt', @formatter.filename
  end

  def test_json_method_returns_a_formatted_json_string
    results = "{\"polygons\":[{\"negative\":false,\"vertices\":[[[0,1],[0,1]],[[1,1],[0,1]],[[1,1],[1,1]],[[0,1],[1,1]]]}],\"lines\":[[[[0,1],[0,1]],[[1,1],[0,1]]],[[[0,1],[0,1]],[[0,1],[1,1]]],[[[1,1],[0,1]],[[1,1],[1,1]]],[[[0,1],[1,1]],[[1,1],[1,1]]]]}"
    assert_equal results, @formatter.json
  end
end

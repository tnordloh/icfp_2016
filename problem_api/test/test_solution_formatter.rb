require File.expand_path '../test_helper.rb', __FILE__
require 'json'

class SolutionFormatterTest < Minitest::Test

  def setup
    @formatter = SolutionFormatter.new(1)
  end

  def test_it_exposes_a_filename
    assert_equal '1.txt', @formatter.filename
  end

  def test_json_method_returns_a_formatted_json_string
    results = "{\"polygons\":[[{\"x\":{\"numerator\":0,\"denomenator\":1},\"y\":{\"numerator\":0,\"denomenator\":1}},{\"x\":{\"numerator\":1,\"denomenator\":1},\"y\":{\"numerator\":0,\"denomenator\":1}},{\"x\":{\"numerator\":1,\"denomenator\":1},\"y\":{\"numerator\":1,\"denomenator\":1}},{\"x\":{\"numerator\":0,\"denomenator\":1},\"y\":{\"numerator\":1,\"denomenator\":1}}]]}"
    assert_equal results, @formatter.json
  end
end

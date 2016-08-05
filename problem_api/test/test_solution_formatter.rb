require File.expand_path '../test_helper.rb', __FILE__
require 'json'

class SolutionFormatterTest < Minitest::Test

  def setup
    @formatter = SolutionFormatter.new(1)
  end

  def test_it_exposes_a_filename
    assert_equal '1.txt', @formatter.filename
  end
end

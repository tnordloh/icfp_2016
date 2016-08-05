require File.expand_path '../test_helper.rb', __FILE__
require_relative '../lib/rationalizer'

class RationalizerTest < Minitest::Test

  def setup
    @rationalizer = Rationalizer.new('1')
  end

  def test_it_has_a_candidate_string
    assert_equal '1', @rationalizer.candidate
  end

  def test_it_knows_if_a_string_is_rational_or_not
    refute  @rationalizer.rational?
    assert  @rationalizer.rational?('1/1')
  end

  def test_it_formats_a_rational_number_string
    assert_equal [1, 1], @rationalizer.format('1/1')
  end

  def test_it_formats_a_whole_number_string
    assert_equal [1, 1], @rationalizer.rationalize('1')
  end

  def test_it_runs_the_candidate
    assert_equal [1, 1], @rationalizer.run
  end
end

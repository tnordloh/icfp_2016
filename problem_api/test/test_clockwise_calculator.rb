require File.expand_path '../test_helper.rb', __FILE__
require_relative '../lib/clockwise_calculator.rb'

class ClockwiseCalculatorTest < Minitest::Test
  def setup
    @calculator = ClockwiseCalculator.new(['5,0', '6,4', '4,5', '1,5', '1,0'])
  end

  def test_returns_whether_or_not_clockwise
    refute @calculator.clockwise?
  end

  def test_it_returns_false_when_counterclockwise
    assert @calculator.counter_clockwise?
  end
end

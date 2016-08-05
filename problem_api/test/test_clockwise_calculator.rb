require File.expand_path '../test_helper.rb', __FILE__
require_relative '../lib/clockwise_calculator.rb'

class ClockwiseCalculatorTest < Minitest::Test
  def setup
    @calculator = ClockwiseCalculator.new(['0,0', '1,0', '1,1', '0,1'])
  end
end

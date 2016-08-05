class Rationalizer
  def initialize(number_string)
    @candidate ||= number_string
  end

  attr_reader :candidate

  def run
    rational?(candidate) ? format(candidate) : rationalize(candidate)
  end

  def rational?(num_string = @candidate)
    num_string.match(/\A[0-9]+\/[0-9]+\z/)
  end

  def format(num_string)
    num_string.split(/\//)
  end

  def rationalize(num_string)
    [num_string, '1']
  end
end

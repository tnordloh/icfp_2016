require_relative "database"
require_relative "problem"
require_relative "../../lib/problem_api"

class Solver
  def self.solve
    new.solve
  end

  def initialize
    @files = Dir.glob(File.join(__dir__, *%w[.. .. problems *.txt]))
    @api = ProblemAPI.new
    @db = Database.new
  end

  attr_reader :files, :api, :db
  private     :files, :api, :db

  def solve
    files.each do |path|
      number = File.basename(path, ".txt").to_i

      next if db.best_score(number) == 1.0
      next if number < 101
      next if number == 750
      next if number == 904
      next if number == 1097

      problem = Problem.new(number, path)
      solution = problem.solve

      if solution
        response = api.submit_solution(solution)
        db.record_if_better(number, response)

        puts
        p response
      end
    end
  end
end

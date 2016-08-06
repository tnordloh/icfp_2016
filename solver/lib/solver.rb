require_relative "database"
require_relative "problem"
require_relative "../../lib/problem_api"

class Solver
  def self.solve(zeroes_only = false)
    new(zeroes_only).solve
  end

  def initialize(zeroes_only = false)
    @files =
      Dir
        .glob(File.join(__dir__, *%w[.. .. problems *.txt]))
        .select { |f| f =~ /\b\d+\.txt\z/ }
    @api = ProblemAPI.new
    @db = Database.new
    @zeroes_only = zeroes_only
  end

  attr_reader :files, :api, :db, :zeroes_only
  private     :files, :api, :db, :zeroes_only

  def solve
    files.each do |path|
      number = File.basename(path, ".txt").to_i

      next if db.best_score(number) == 1.0
      next if db.best_score(number) != 0.0 and zeroes_only

      problem = Problem.new(number, path)
      solution = problem.solve

      if solution
        begin
          response = api.submit_solution(solution)
          db.record_if_better(number, response)

          puts
          p response
        rescue RestClient::BadRequest
          puts
          puts "Skipping tricky problem: ##{number}"
        end
      end
    end
  end
end

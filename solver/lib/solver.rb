require_relative "database"
require_relative "problem"
require_relative "../../lib/problem_api"

class Solver
  def self.solve
    new.solve
  end

  def initialize
    @files =
      Dir
        .glob(File.join(__dir__, *%w[.. .. problems *.txt]))
        .select { |f| f =~ /\b\d+\.txt\z/ }
    @api = ProblemAPI.new
    @db = Database.new
  end

  attr_reader :files, :api, :db
  private     :files, :api, :db

  def solve
    files.each do |path|
      number = File.basename(path, ".txt").to_i

      next if db.best_score(number) == 1.0

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

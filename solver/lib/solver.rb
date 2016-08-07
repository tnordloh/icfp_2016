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
    scores = db.scores
    files.sort_by { |path|
      number = File.basename(path, ".txt").to_i
      scores[number] || 0
    }.each do |path|
      number = File.basename(path, ".txt").to_i

      old_score = scores[number] || 0
      next if old_score == 1.0
      next if old_score != 0 && zeroes_only

      problem = Problem.new(number, path)
      solution = problem.solve

      if solution && !under_size_limit?(solution)
        puts
        puts "Solution too large:  #{number}"
      elsif solution
        begin
          puts
          puts "Previous score:  #{old_score}"

          response = api.submit_solution(solution)
          db.record_if_better(number, response)

          p response
        rescue RestClient::BadRequest => error
          puts "Error:  #{JSON.parse(error.response.body)["error"]}"
          puts "Skipping tricky problem: ##{number}"
        end
      end
    end
  end

  def under_size_limit?(path)
    File.read(path).count("^ \n\t") <= 5_000
  end
end

require "yaml/store"

require_relative "problem"
require_relative "../../lib/problem_api"

class Solver
  PROGRESS_FILE = File.join(__dir__, *%w[.. data progress.yaml])

  def self.solve
    new.solve
  end

  def initialize
    @files = Dir.glob(File.join(__dir__, *%w[.. .. problems *.txt]))
    @api = ProblemAPI.new
    @db = YAML::Store.new(PROGRESS_FILE)
  end

  attr_reader :files, :api, :db
  private     :files, :api, :db

  def solve
    files.each do |path|
      number = File.basename(path, ".txt").to_i

      best_score = db.transaction(true) {
        db.root?(number) ? db[number]["resemblance"] : 0
      }
      next if best_score == 1.0

      problem = Problem.new(number, path)
      solution = problem.solve

      if solution
        response = api.submit_solution(solution)
        db.transaction do
          db[number] = response
        end

        puts
        p response
      end
    end
  end
end

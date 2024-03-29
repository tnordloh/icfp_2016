require "pstore"

class Database
  PROGRESS_FILE = File.join(__dir__, *%w[.. data progress.pstore])

  def initialize
    @db = PStore.new(PROGRESS_FILE)
  end

  attr_reader :db
  private     :db

  def best_score(number)
    db.transaction(true) {
      db.root?(number) ? db[number]["resemblance"] : 0
    }
  end

  def scores
    db.transaction(true) {
      Hash[db.roots.map { |number| [number, db[number]["resemblance"]] }]
    }
  end

  def record_if_better(number, result)
    db.transaction do
      old_score = db.root?(number) ? db[number]["resemblance"] : 0
      if result["resemblance"] > old_score
        db[number] = result
      end
    end
  end
end

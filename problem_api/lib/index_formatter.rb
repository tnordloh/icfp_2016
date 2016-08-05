require 'json'

class IndexFormatter
  def initialize
    @filenames ||= 
      Dir.entries(File.expand_path('../../../problems/', __FILE__))
      .select {|fn| fn.match(/\A[0-9]+\.txt\z/) }
      .sort
  end

  attr_reader :filenames

  def json
    @json ||= build_links_hash
  end

  private

  def build_links_hash
    initial_hash = { "files" => [] }
    filenames.reduce(initial_hash) { |file, acc| acc["files"] << url("/#{file}") }
  end
end

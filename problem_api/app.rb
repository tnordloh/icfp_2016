require 'sinatra'
require_relative 'lib/problem_formatter'

set :public_dir, File.dirname(__FILE__) + '/javascripts'

get '/' do
  @filenames = Dir.entries(File.expand_path('../../problems/', __FILE__))
    .select { |fn| fn.match(/\A[0-9]+\.txt\z/)}
    .map { |fn| fn.gsub(/\.txt/, '') }
    .sort_by { |file| file.to_i }
  erb :index
end

get '/:id' do
  @model = ProblemFormatter.new(params['id']).json
  erb :show
end

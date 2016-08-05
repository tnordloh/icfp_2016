require 'sinatra'
require_relative 'lib/problem_formatter'

get '/' do
  Dir.entries(File.expand_path('../../problems/', __FILE__))
end

get '/:id' do
  ProblemFormatter.new(params['id']).json
end

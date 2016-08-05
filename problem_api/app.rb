require 'sinatra'
require_relative 'lib/problem_formatter'
require_relative 'lib/solution_formatter'
require_relative 'lib/dir_builder'

set :public_dir, File.dirname(__FILE__) + '/javascripts'

get '/' do
  @filenames = DirBuilder.run('problems')
  erb :index
end

get '/solutions' do
  @filenames = DirBuilder.run('solutions')
  erb :index
end

 get '/solutions/:id' do
   @model = SolutionFormatter.new(params['id']).json
   erb :solutions_show
 end

get '/:id' do
  @model = ProblemFormatter.new(params['id']).json
  erb :show
end

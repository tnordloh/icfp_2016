require 'sinatra'
require_relative 'lib/problem_formatter'

get '/' do
  'Hello, World!'
end

get '/:id' do
  "Hello #{params['id']}!"
end
